import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:movie_info_searcher/ui/searching/searching_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/models/omdbi_response.dart';
import '../../data/models/search_data.dart';
import '../components/movie_card.dart';
import '../components/searching_card.dart';

class SearchingPage extends StatefulWidget {
  static const String route = "/searching";

  const SearchingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  bool _showScrollUpButton = false;
  final _scrollController = ScrollController();
  SearchData searchData = const SearchData();

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.title)),
      body: _buildBody(),
      floatingActionButton: _showScrollUpButton
          ? FloatingActionButton(
              backgroundColor: Colors.grey[900],
              onPressed: _scrollToTop,
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 36,
              ),
            )
          : null,
    );
  }

  Widget buildList(List<Search> list, bool isEnd) {
    return ListView.builder(
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return index >= list.length
            ? buildBottomLoader()
            : Flexible(
                child: movieCard(list[index], (item) {
                  FocusScope.of(context).unfocus();
                  context.read<SearchingBloc>().add(GetDetails(movieId: item));
                }),
              );
      },
      itemCount: isEnd || list.isEmpty ? list.length : list.length + 1,
    );
  }

  void _onScroll() {
    if (_isBottom) {
      searchData = searchData.copyWith(page: searchData.page + 1);
      context.read<SearchingBloc>().add(SearchMore(searchData));
    }
    bool isScrolled = _scrollController.offset >= 400;
    if (isScrolled != _showScrollUpButton) {
      setState(() {
        _showScrollUpButton = isScrolled;
      });
    }
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

  void showError(BuildContext newContext, String? message) async {
    ScaffoldMessenger.of(newContext).showSnackBar(SnackBar(
      content: Text(
        message ?? AppLocalizations.of(newContext)!.unexpected_error,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Colors.black38,
      duration: const Duration(seconds: 2),
    ));
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  Widget _buildBody() {
    return BlocConsumer<SearchingBloc, SearchingState>(
      builder: (context, state) {
        return _buildMainList(state.list, state.hasReachedMax);
      },
      listenWhen: (context, state) {
        return state is NotifAction;
      },
      buildWhen: (context, state) {
        return state is! NotifAction;
      },
      listener: (context, action) {
        if (action is Loading) {
          if (action.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
        } else if (action is Navigate) {
          Navigator.pushNamed(context, action.route, arguments: action.data);
        } else if (action is ErrorAction) {
          showError(context, action.message);
        }
      },
    );
  }

  Widget _buildMainList(List<Search> list, bool isEnd) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: list.isEmpty ? 1 : list.length + (isEnd ? 0 : 1),
        itemBuilder: ((context, index) {
          if (index == 0) {
            return SearchingCard(onSearch: (data) {
              FocusScope.of(context).unfocus();
              searchData = data;
              context.read<SearchingBloc>().add(SearchInitial(data: data));
            });
          } else if (index < list.length) {
            return movieCard(list[index], (item) {
              FocusScope.of(context).unfocus();
              context.read<SearchingBloc>().add(GetDetails(movieId: item));
            });
          }
          return buildBottomLoader();
        }));
  }
}
