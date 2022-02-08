
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/navigation/mis_pages.dart';
import 'package:movie_info_searcher/ui/components/movie_card.dart';
import 'package:movie_info_searcher/ui/components/searching_card.dart';

class MainScreen extends StatefulWidget{
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

class _MainScreenState extends State<MainScreen>{

  List<Search> mockList = [
    Search(
        title: "One Flew Over the Cuckoos Nest",
        year: "1975",
        imdbID: "tt0073486",
        type: "movie",
        poster: "https://m.media-amazon.com/images/M/MV5BZjA0OWVhOTAtYWQxNi00YzNhLWI4ZjYtNjFjZTEyYjJlNDVlL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"
    ),
    Search(
        title: "Rogue One",
        year: "2016",
        imdbID: "tt3748528",
        type: "movie",
        poster: "https://m.media-amazon.com/images/M/MV5BMjEwMzMxODIzOV5BMl5BanBnXkFtZTgwNzg3OTAzMDI@._V1_SX300.jpg"
    ),
    Search(
        title: "Ready Player One",
        year: "2018",
        imdbID: "tt1677720",
        type: "movie",
        poster: "https://m.media-amazon.com/images/M/MV5BY2JiYTNmZTctYTQ1OC00YjU4LWEwMjYtZjkwY2Y5MDI0OTU3XkEyXkFqcGdeQXVyNTI4MzE4MDU@._V1_SX300.jpg"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Info Searcher"),
        elevation: 1,
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
              scrollDirection: Axis.vertical,
              children:  [
                const SearchingCard(),
                buildMovieList(mockList)
              ])

      ),
    );
  }

  Widget buildMovieList(List<Search> list){
    if (list.isEmpty) {
      return buildEmptyList();
    } else {
      return buildList(list);
    }


  }

  Widget buildEmptyList(){
    return Container();
  }

  Widget buildList(List<Search> list){
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          return movieCard(list[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox( height: 16,);
        },
        itemCount: list.length);
  }

}

