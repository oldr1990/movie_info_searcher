

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_info_searcher/ui/searching/searching_bloc.dart';
import 'package:movie_info_searcher/ui/searching/searching_page.dart';

class SearchingScreen extends StatelessWidget{
  const SearchingScreen({Key? key}) : super(key: key);
  static const String route = "/searching";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SearchingBloc(context: context),
        child: const SearchingPage(),
      );
  }
}