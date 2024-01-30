import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';

Future<List<ProfileEntity>> getProfileTest() async {
  final response =
      await rootBundle.loadString('test_data/profile_entity_test_data.json');
  final jsonList = await json.decode(response);

  final List<ProfileEntity> profileList = jsonList
      .map<ProfileEntity>(
        (json) => ProfileEntity.fromJson(json),
      )
      .toList();

  return Future.value(profileList);
}
