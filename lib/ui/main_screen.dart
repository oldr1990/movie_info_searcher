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
      context.loaderOverlay.show();
      return Container();
    } else if (state is Error) {
      context.loaderOverlay.hide();
      return buildError(state.errorMessage);
    } else if (state is DataLoaded) {
      context.loaderOverlay.hide();
      return buildList(state.data, onItemTap);
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
