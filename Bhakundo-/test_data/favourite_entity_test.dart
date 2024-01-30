import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nba_hub/features/favourite/domain/entity/favourite_entity.dart';

Future<List<FavouriteEntity>> getFavouriteTest() async {
  final response =
      await rootBundle.loadString('test_data/favourite_entity_test_data.json');
  final jsonList = await json.decode(response);

  final List<FavouriteEntity> favouriteList = jsonList
      .map<FavouriteEntity>(
        (json) => FavouriteEntity.fromJson(json),
      )
      .toList();

  return Future.value(favouriteList);
}
