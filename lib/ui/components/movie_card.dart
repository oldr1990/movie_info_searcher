import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/ui/theme.dart';

Widget movieCard(Search item) {
  return Card(
      elevation: 8,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
        CachedNetworkImage(
          imageUrl: item.poster,
          fit: BoxFit.fill,
          width: 150,
          height: 223,
        ),
        Column(
            mainAxisSize: MainAxisSize.max,
            children: [
          SizedBox(
            width: 200,
            height: 223,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item.title,
                    style: MovieInfoSercherTheme.darkTextTheme.headline2,
                  ),
                ),
                Positioned(
                  child: Text(
                    item.year,
                    style: MovieInfoSercherTheme.darkTextTheme.headline2,
                  ),
                  bottom: 16,
                  left: 16,
                ),
                Positioned(
                  child: Text(
                    item.type,
                    style: MovieInfoSercherTheme.darkTextTheme.headline2,
                  ),
                  bottom: 16,
                  right: 16,
                ),
              ],
            ),
          )
        ])
      ])
  );
}
