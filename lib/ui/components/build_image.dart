
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget imageBuilder(String url, double width, double height){
  if(url == "N/A"){
    return  Image(
      image: const AssetImage("assets/images/no_image_availiable.jpeg"),
      width: width,
      height: height,
      fit: BoxFit.fill,);
  } else {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.fill,
      width: width,
      height: height,
    );
  }
}