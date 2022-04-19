import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/data/models/searching_manager.dart';
import 'package:movie_info_searcher/navigation/app_state_manager.dart';
import 'package:movie_info_searcher/navigation/mis_pages.dart';
import 'package:movie_info_searcher/ui/components/movie_card.dart';
import 'package:movie_info_searcher/ui/components/searching_card.dart';
import 'package:movie_info_searcher/network/omdbi_service_impl.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: MovieInfoSearcherPages.search,
        key: ValueKey(MovieInfoSearcherPages.search),
        child: const MainScreen());
  }

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  SearchData? _searchData;
  final List<Search> _listOfMovies = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context,listen:false).goToPage(MovieInfoSearcherPage.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Info Searcher"),
        elevation: 1,
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(scrollDirection: Axis.vertical, children: [
            SearchingCard(
              onSearch: (data) {
               setState(() {
                 _searchData = data;
               });
              },
            ),
            const SizedBox(
              width: 16,
              height: 16,
            ),
            buildMovieList((item) {
              Provider.of<SearchingManager>(context,listen: false).selectMovie(item);
            })
          ])),
    );
  }

  Widget buildMovieList( Function(Search) onItemTap) {
    log('BuildMovieList');
    if(_searchData == null){
      return buildEmptyList();
    } else {
      return FutureBuilder<Omdbi_response>(
          future: startSearching(_searchData!),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                log(snapshot.error.toString());
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                );
              }
              final data = snapshot.data;
              if (data != null){
                if(data.search.isNotEmpty){
                  _listOfMovies.clear();
                  _listOfMovies.addAll(data.search);
                }
              }
              if(_listOfMovies.isNotEmpty){
                return buildList(_listOfMovies, onItemTap);
              } else {
                return buildEmptyList();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },);
    }
  }

  Widget buildEmptyList() {
    return Container();
  }

  Widget buildList(List<Search> list, Function(Search) onItemTap) {
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

  Future<Omdbi_response> startSearching(SearchData searchData) async {
    final json = await OmdbiService().searchMovies(
        searchData.search, searchData.type, searchData.year);
    final jsonMap = jsonDecode(json);
    return Omdbi_response.fromJson(jsonMap);
  }
}
