import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/ui/hero_tags.dart';
import 'package:movie_info_searcher/ui/theme.dart';

import 'build_image.dart';

Widget movieCard(Search item, Function(String) onItemTap) {
  return GestureDetector(
    onTap: () => {onItemTap(item.imdbID)},
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 8,
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: item.imdbID + HeroTags.poster,
                child: imageBuilder(item.poster, 150, 223),
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
                        Hero(
                          tag: item.imdbID + HeroTags.title,
                          child: Text(
                            item.title,
                            style: MovieInfoSercherTheme.darkTextTheme.headline2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: item.imdbID + HeroTags.year,
                              child: Text(
                                item.year,
                                style:
                                    MovieInfoSercherTheme.darkTextTheme.headline2,
                              ),
                            ),
                            Hero(
                              tag: item.imdbID + HeroTags.type,
                              child: Text(
                                item.type,
                                style:
                                    MovieInfoSercherTheme.darkTextTheme.headline2,
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            )
          ])),
    ),
  );
}
