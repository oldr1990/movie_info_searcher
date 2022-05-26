import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:movie_info_searcher/data/models/DetailsData.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:movie_info_searcher/ui/searching/searching_screen.dart';
import 'package:movie_info_searcher/ui/theme.dart';

void main() {
  BlocOverrides.runZoned(
        () => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        routes: {
          SearchingScreen.route: (context) => const SearchingScreen(),
        },
        onGenerateRoute: (settings) {
          if(settings.name == DetailScreen.route){
            return MaterialPageRoute(builder: (context) {
              return DetailScreen(data: settings.arguments as DetailsData);
            });
          }
        },
        theme: MovieInfoSercherTheme.dark(),
        title: "Movie Info Searcher",
        home: const SearchingScreen(),
      ),
    );
  }
}
