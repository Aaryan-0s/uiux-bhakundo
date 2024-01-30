import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_entity.dart';

Future<List<StandingEntity>> getAllStandingTest() async {
  final response =
      await rootBundle.loadString('test_data/standing_entity_test_data.json');
  final jsonList = await json.decode(response);

  final List<StandingEntity> standingList = jsonList
      .map<StandingEntity>(
        (json) => StandingEntity.fromJson(json),
      )
      .toList();

  return Future.value(standingList);
}
