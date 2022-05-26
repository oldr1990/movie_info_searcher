import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:movie_info_searcher/ui/searching/searching_bloc.dart';

import '../../data/models/omdbi_response.dart';
import '../components/movie_card.dart';
import '../components/searching_card.dart';
import '../details_screen.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  bool isRedirected = false;
  final _scrollController = ScrollController();
  final PagingController<int, Search> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        controller: _scrollController,
        children: [
          SearchingCard(
            onSearch: (data) {
              FocusScope.of(context).unfocus();
              _pagingController.refresh();
              context.read<SearchingBloc>().add(SearchInitial(data: data));
            },
            searchData: context.read<SearchingBloc>().searchData,
          ),
          const SizedBox(
            height: 16,
          ),
          BlocConsumer<SearchingBloc, SearchingState>(
            buildWhen: (context, state) {
              return state.status != SearchStatus.details &&
                  state.status != SearchStatus.failure;
            },
            listenWhen: (context, state) {
              return state.status == SearchStatus.details ||
                  state.status == SearchStatus.failure;
            },
            listener: (context, state) {
              context.loaderOverlay.hide();
              if (state.status == SearchStatus.details) {
                Navigator.pushNamed(context, DetailScreen.route,
                    arguments: state.details);
              } else if (state.status == SearchStatus.failure) {
                showError(state.error);
              }
            },
            builder: (context, state) {
              if (state.status == SearchStatus.success) {
                context.loaderOverlay.hide();
                return buildList(state.list, state.hasReachedMax);
              } else if (state.status == SearchStatus.loading) {
                context.loaderOverlay.show();
                return buildList(state.list, state.hasReachedMax);
              } else {
                context.loaderOverlay.hide();
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildList(List<Search> list, bool isEnd) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return index >= list.length
            ? buildBottomLoader()
            : movieCard(list[index], (item) {
                FocusScope.of(context).unfocus();
                context.read<SearchingBloc>().add(GetDetails(movieId: item));
              });
      },
      itemCount: isEnd || list.isEmpty ? list.length : list.length + 1,
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<SearchingBloc>().add(SearchMore());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Widget buildBottomLoader() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 5),
        ),
      ),
    );
  }

  void showError(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message ?? "Unexpected Error",
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.black38,
      duration: const Duration(seconds: 2),
    ));
  }
}