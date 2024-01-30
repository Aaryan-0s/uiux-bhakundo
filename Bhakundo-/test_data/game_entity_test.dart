import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';

Future<List<GameEntity>> getGameListTest() async {
  final response = await rootBundle.loadString('test_data/game_test_data.json');
  final jsonList = await json.decode(response);
  final List<GameEntity> gameList = jsonList
      .map<GameEntity>(
        (json) => GameEntity.fromJson(json),
      )
      .toList();

  return Future.value(gameList);
}
