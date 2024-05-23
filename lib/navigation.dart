import 'ui/searching/searching_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_info_searcher/data/models/details_data.dart';
import 'package:movie_info_searcher/ui/details_screen.dart';
import 'package:flutter/material.dart';

import 'ui/searching/searching_page.dart';

Route<dynamic>? Function(RouteSettings)? navigator = (settings) {
  if (settings.name == SearchingPage.route) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => SearchingBloc(),
        child: const SearchingPage(),
      );
    });
  } else if (settings.name == DetailScreen.route) {
    return MaterialPageRoute(builder: (context) {
      return DetailScreen(data: settings.arguments as DetailsData);
    });
  } else {
    return null;
  }
};
