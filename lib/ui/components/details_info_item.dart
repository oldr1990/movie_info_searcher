import 'package:flutter/material.dart';

import '../../data/models/details_info_item_data.dart';
import '../theme.dart';

Widget detailsInfoItem(DetailsInfoItemData item) {
  return Row(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
      SizedBox(
          width: 100,
          child: Text(
            item.description,
            style: MovieInfoSercherTheme.darkTextTheme.displaySmall,
          )),
      Flexible(
        child: Text(
          item.value,
          style: MovieInfoSercherTheme.darkTextTheme.displaySmall,
            textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
