import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/DetailsData.dart';
import 'package:movie_info_searcher/network/repotitory.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:movie_info_searcher/ui/main_screen.dart';
import 'package:movie_info_searcher/ui/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RepositoryImpl>(
            create: (context) => RepositoryImpl(),
            lazy: false,
          )
        ],
        child: MaterialApp(
          routes: {
            MainScreen.route: (context) => const MainScreen(),
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
          home: const MainScreen(),
        ));
  }
}
