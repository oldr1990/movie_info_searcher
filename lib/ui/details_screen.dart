import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/details_info_item_data.dart';
import 'package:movie_info_searcher/ui/components/build_image.dart';
import 'package:movie_info_searcher/ui/components/details_info_item.dart';
import 'package:movie_info_searcher/ui/hero_tags.dart';
import 'package:movie_info_searcher/ui/theme.dart';

import '../data/models/details_data.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.data}) : super(key: key);
  static const String route = "/details";
  final DetailsData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title!),
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
        child: ListView(
          children: [
            poster(data.poster!),
            buildRatingCard(),
            buildInfoCard(getMainInfo()),
            buildPlot(),
            buildInfoCard(getCrewInfo()),
          ],
        ),
      ),
    );
  }

  Widget poster(url) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: data.imdbID! + HeroTags.poster,
            child: imageBuilder(url, 300, 446),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(List<DetailsInfoItemData> list) {
    if (list.isEmpty) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return detailsInfoItem(list[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: list.length),
          ),
        ),
      );
    }
  }

  List<DetailsInfoItemData> getMainInfo() {
    List<DetailsInfoItemData> list = [];
    if (notNull(data.released)) {
      list.add(
          DetailsInfoItemData(description: "Released:", value: data.released!));
    }
    if (notNull(data.genre)) {
      list.add(DetailsInfoItemData(description: "Genre:", value: data.genre!));
    }
    if (notNull(data.country)) {
      list.add(
          DetailsInfoItemData(description: "Country:", value: data.country!));
    }
    if (notNull(data.language)) {
      list.add(
          DetailsInfoItemData(description: "Language:", value: data.language!));
    }
    return list;
  }

  List<DetailsInfoItemData> getCrewInfo() {
    List<DetailsInfoItemData> list = [];
    if (notNull(data.writer)) {
      list.add(
          DetailsInfoItemData(description: "Writer:", value: data.writer!));
    }
    if (notNull(data.director)) {
      list.add(
          DetailsInfoItemData(description: "Director:", value: data.director!));
    }
    if (notNull(data.actors)) {
      list.add(
          DetailsInfoItemData(description: "Actors:", value: data.actors!));
    }
    return list;
  }

  Widget buildPlot() {
    if (notNull(data.plot)) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                data.plot!,
                style: MovieInfoSercherTheme.darkTextTheme.displaySmall,
                textAlign: TextAlign.justify,
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildRatingCard() {
    if (data.ratings != null && data.ratings!.isNotEmpty) {
      Ratings imdb = data.ratings!.firstWhere(
          (element) => element.source == "Internet Movie Database",
          orElse: () => Ratings());
      Ratings metacritic = data.ratings!.firstWhere(
          (element) => element.source == "Metacritic",
          orElse: () => Ratings());
      Ratings rotten = data.ratings!.firstWhere(
          (element) => element.source == "Rotten Tomatoes",
          orElse: () => Ratings());
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (imdb.value != null) buildImdbRating(imdb),
                if (rotten.value != null) buildRottenRating(rotten),
                if (metacritic.value != null) buildMetacriticRating(metacritic),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildImdbRating(Ratings rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Text(
              "IMDb",
              style: MovieInfoSercherTheme.lightTextTheme.displayMedium,
            ),
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 32,
              ),
            ),
            Text(
              rating.value!,
              style: MovieInfoSercherTheme.darkTextTheme.displayMedium,
            )
          ],
        )
      ],
    );
  }

  Widget buildRottenRating(Ratings rating) {
    int score = int.parse(rating.value!.replaceAll('%', ''));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
          child: Text(
            "Rotten Tomatoes",
            style: MovieInfoSercherTheme.darkTextTheme.titleLarge,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image(
                image: rottenImage(score),
                width: 32,
                height: 32,
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(
              rating.value!,
              style: TextStyle(
                color: rottenColor(score),
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildMetacriticRating(Ratings rating) {
    int number = int.parse(rating.value!.split("/").first);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/metacritic.png'),
                width: 32,
                height: 32,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "metacritic",
                  style: MovieInfoSercherTheme.darkTextTheme.displayMedium,
                ),
              )
            ],
          ),
          Card(
            color: metacriticColor(number),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: Text(
                  number.toString(),
                  style: MovieInfoSercherTheme.darkTextTheme.displayMedium,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color metacriticColor(int rating) {
    if (rating < 40) {
      return Colors.red;
    } else if (rating < 60) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  bool notNull(String? value) {
    return value != null && value != "N/A" && value.isNotEmpty;
  }

  AssetImage rottenImage(int score) {
    if (score < 60) {
      return const AssetImage('assets/images/rt_rotten.png');
    } else if (score < 75) {
      return const AssetImage('assets/images/rt_avarage.png');
    } else {
      return const AssetImage('assets/images/rt_best.png');
    }
  }

  Color rottenColor(int rating) {
    if (rating < 60) {
      return Colors.red;
    } else if (rating < 75) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}
