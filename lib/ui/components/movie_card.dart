import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/ui/theme.dart';

Widget movieCard(Search item) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0)
    ),
      elevation: 8,
      child: Row(
          children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: item.poster,
            fit: BoxFit.fill,
            width: 150,
            height: 223,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 223,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        item.title,
                        style: MovieInfoSercherTheme.darkTextTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.year,
                          style: MovieInfoSercherTheme.darkTextTheme.headline2,
                        ),
                        Text(
                          item.type,
                          style: MovieInfoSercherTheme.darkTextTheme.headline2,
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        )
      ]));
}
