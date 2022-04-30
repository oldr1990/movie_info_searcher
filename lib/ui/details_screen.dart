
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_info_searcher/data/models/details_info_item_data.dart';
import 'package:movie_info_searcher/ui/components/details_info_item.dart';
import 'package:movie_info_searcher/ui/hero_tags.dart';

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
           buildInfoCard(getMainInfo()),
         ],
       ) ,
     ),
   );
  }

  Widget poster(url){
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: data.imdbID! + HeroTags.poster,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
            width: 300,
            height: 446,
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(List<DetailsInfoItemData> list){
    if(list.isEmpty){
      return Container();
    } else {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
      );
    }
  }

  List<DetailsInfoItemData> getMainInfo(){
    List<DetailsInfoItemData> list = [];
    if(notNull(data.released)){
      list.add(DetailsInfoItemData(description: "Released:", value: data.released!));
    }
    if(notNull(data.genre)){
      list.add(DetailsInfoItemData(description: "Genre:", value: data.genre!));
    }
    if(notNull(data.country)){
      list.add(DetailsInfoItemData(description: "Country:", value: data.country!));
    }
    if(notNull(data.language)){
      list.add(DetailsInfoItemData(description: "Language:", value: data.language!));
    }
    return list;
  }

  bool notNull(String? value){
    return value != null && value != "N/A" && value.isNotEmpty;
}
}
