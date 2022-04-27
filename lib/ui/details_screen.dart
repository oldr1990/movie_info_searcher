
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../data/models/DetailsData.dart';

class DetailScreen extends StatelessWidget{
  const DetailScreen({Key? key, required this.data} ) : super(key: key);
   static const String route = "/details";
   final DetailsData data;

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
