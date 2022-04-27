
import 'package:cached_network_image/cached_network_image.dart';
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
       title:  Text(data.title!),
       elevation: 1,
     ),
     body: Container(
       padding: const EdgeInsets.all(16.0),
       child: ListView(
         children: [
           poster(data.poster!),
         ],
       ) ,
     ),
   );
  }

  Widget poster(url){
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          width: 300,
          height: 446,
        ),
      ),
    );

  }
}
