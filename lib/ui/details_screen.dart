
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_info_searcher/navigation/mis_pages.dart';

class DetailScreen extends StatefulWidget{

  const DetailScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: MovieInfoSearcherPages.details,
        key: ValueKey(MovieInfoSearcherPages.details),
        child: const DetailScreen());
  }

  @override
  State<StatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Movie Info Searcher"),
       elevation: 1,
     ),
     body: const Text("Movie Info Searcher"),
   );
  }
}