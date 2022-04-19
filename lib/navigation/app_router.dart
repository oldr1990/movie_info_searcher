import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/searching_manager.dart';
import 'package:movie_info_searcher/navigation/app_state_manager.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:movie_info_searcher/ui/main_screen.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  late final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final SearchingManager searchingManager;

  AppRouter({
    required this.appStateManager,
    required this.searchingManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    searchingManager.addListener(notifyListeners);
    appStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        MainScreen.page(),
        if (searchingManager.selectedMovie != null) DetailScreen.page(),
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
