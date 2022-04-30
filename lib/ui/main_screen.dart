import 'dart:developer';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer<RepositoryImpl>(builder: (context, repository, child) {
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
                  repository.getMovies(data);
                },
              ),
              const SizedBox(
                width: 16,
                height: 16,
              ),
              buildMovieList((item) {
                getDetails(item, repository);
              }, repository.state),
            ])),
      );
    });
  }

  Widget buildMovieList(Function(String) onItemTap, MainScreenState state) {
    log('BuildMovieList');
    log('State $state');
    if (state is Loading) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is Error) {
      return Center(
        child: Text(
          state.errorMessage ?? "Unknown Error!",
          textAlign: TextAlign.center,
          textScaleFactor: 1.3,
        ),
      );
    } else if (state is DataLoaded) {
      return buildList(state.data, onItemTap);
    } else {
      return buildEmptyList();
    }
  }

  void getDetails(String id, RepositoryImpl repositoryImpl) async {
    context.loaderOverlay.show();
    DetailsData data = await repositoryImpl.getDetails(id);
    context.loaderOverlay.hide();
    Navigator.pushNamed(context, DetailScreen.route, arguments: data);
  }

  Widget buildEmptyList() {
    return Container();
  }

  Widget buildList(List<Search> list, Function(String) onItemTap) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return movieCard(list[index], onItemTap);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: list.length);
  }
}
