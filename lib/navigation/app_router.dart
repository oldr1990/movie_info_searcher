import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/searching_manager.dart';
import 'package:movie_info_searcher/network/repotitory.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:movie_info_searcher/ui/main_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  late final GlobalKey<NavigatorState> navigatorKey;
  final SearchingManager searchingManager;
  final RepositoryImpl repositoryImpl;

  AppRouter({
    required this.searchingManager,
    required this.repositoryImpl})
      : navigatorKey = GlobalKey<NavigatorState>() {
    searchingManager.addListener(notifyListeners);
    repositoryImpl.addListener(notifyListeners);
  }

  @override
  void dispose() {
    searchingManager.removeListener(notifyListeners);
    repositoryImpl.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        MainScreen.page(),
        if (repositoryImpl.details.imdbID != null) DetailScreen.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    return;
  }
}
