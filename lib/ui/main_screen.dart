import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_info_searcher/data/models/DetailsData.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/network/repotitory.dart';
import 'package:movie_info_searcher/ui/components/movie_card.dart';
import 'package:movie_info_searcher/ui/components/searching_card.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:movie_info_searcher/ui/main_screen_state.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String route = "/main";

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isRedirected = false;
  final PagingController<int, Search> _pagingController =
      PagingController(firstPageKey: 0);

  late RepositoryImpl _repositoryImpl;

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future _fetchPage(int key) async {
    final page = await _repositoryImpl.loadMore();
    if(key == 10){
      _pagingController.appendLastPage(page);
    } else{
      _pagingController.appendPage(page, key+1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RepositoryImpl>(builder: (context, repository, child) {
      _repositoryImpl = repository;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Info Searcher"),
          elevation: 1,
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            child: ListView(scrollDirection: Axis.vertical, children: [
              SearchingCard(
                onSearch: (data) {
                  FocusScope.of(context).unfocus();
                  _repositoryImpl.setSearchData(data);
                  _pagingController.refresh();
                },
              searchData: _repositoryImpl.currentSearchData,),
              const SizedBox(
                width: 16,
                height: 16,
              ),
              buildMovieList((item) {
                getDetails(item);
              }),
            ])),
      );
    });
  }

  Widget buildMovieList(Function(String) onItemTap) {
    final state = _repositoryImpl.state;
    log('BuildMovieList');
    log('State $state');
    if (state is Error) {
      context.loaderOverlay.hide();
      _pagingController.error = state.errorException;
      return buildList(onItemTap);
    } else if (state is SearchDataUpdated) {
      context.loaderOverlay.hide();
      return buildList(onItemTap);
    } else {
      context.loaderOverlay.hide();
      return buildEmptyList();
    }
  }

  Widget buildError(String? message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
            color: Colors.red,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Something went wrong...",
            textAlign: TextAlign.center,
            textScaleFactor: 1.3,
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            message ?? "Unknown Error!",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, color: Colors.red),
          ),
        ],
      ),
    );
  }

  SnackBar getSnackBar(String? message) {
    return SnackBar(
        padding: const EdgeInsets.all(16),
        content: Text(
          message ?? "Unknown Error!",
          textAlign: TextAlign.center,
          textScaleFactor: 1.3,
        ));
  }

  void getDetails(String id) async {
    context.loaderOverlay.show();
    DetailsData data = await _repositoryImpl.getDetails(id);
    context.loaderOverlay.hide();
    Navigator.pushNamed(context, DetailScreen.route, arguments: data);
  }

  Widget buildEmptyList() {
    return Container();
  }

  Widget buildList(Function(String) onItemTap) {
    return PagedListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Search>(
        itemBuilder: (context, item, index) =>
            movieCard(item, onItemTap),
      ),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
    );
  }
}
