import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_info_searcher/ui/searching/searching_bloc.dart';

import '../../data/models/omdbi_response.dart';
import '../components/movie_card.dart';
import '../components/searching_card.dart';

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
      ..removeListener(_fetchPage)
      ..dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(_fetchPage);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage();
    });
    super.initState();
  }

  Future _fetchPage() async {
    context.read<SearchingBloc>().add(SearchMore());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SearchingCard(
          onSearch: (data) {
            _pagingController.refresh();
            context.read<SearchingBloc>().add(SearchInitial(data: data));
          },
          searchData: context.read<SearchingBloc>().searchData,
        ),
        BlocBuilder<SearchingBloc, SearchingState>(
          builder: (context, state) {
            switch (state.status) {
              case SearchStatus.initial:
                return Container();
              case SearchStatus.success:
                if (state.hasReachedMax) {
                  _pagingController.appendLastPage(state.list);
                } else {
                  _pagingController.appendPage(state.list, 1);
                }
                return buildList((p0) => {});
              case SearchStatus.failure:
                _pagingController.error = "Unexpected error...";
                return buildList((p0) => {});
            }
          },
        )
      ],
    );
  }

  Widget buildList(Function(String) onItemTap) {
    return PagedListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Search>(
        itemBuilder: (context, item, index) => movieCard(item, onItemTap),
      ),
    );
  }
}
