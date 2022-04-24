import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/searching_manager.dart';
import 'package:movie_info_searcher/navigation/app_router.dart';
import 'package:movie_info_searcher/network/repotitory.dart';
import 'package:movie_info_searcher/ui/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _searchingManager = SearchingManager();
  final _repository = RepositoryImpl();
  late AppRouter _router;

  @override
  void initState() {
    _router = AppRouter(
        searchingManager: _searchingManager, repositoryImpl: _repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _searchingManager),
        ChangeNotifierProvider<RepositoryImpl>(
          create: (context) => RepositoryImpl(),
          lazy: false,
        )
      ],
      child: MaterialApp(
          theme: MovieInfoSercherTheme.dark(),
          title: "Movie Info Searcher",
          home: Router(
            routerDelegate: _router,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}
