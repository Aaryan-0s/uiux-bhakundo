import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_player_entity.dart';

Future<List<StandingPlayerEntity>> getAllStandingPlayerTest() async {
  final response = await rootBundle
      .loadString('test_data/standing_player_entity_test_data.json');
  final jsonList = await json.decode(response);

  final List<StandingPlayerEntity> standingPlayerList = jsonList
      .map<StandingPlayerEntity>(
        (json) => StandingPlayerEntity.fromJson(json),
      )
      .toList();

  return Future.value(standingPlayerList);
}
