import 'package:nba_hub/features/fixture/domain/entity/fixture_info_entity.dart';

import '../../domain/entity/fixture_entity.dart';

class FixtureState {
  final bool isLoading;
  final List<FixtureEntity> fixture;
  final List<FixtureInfoEntity> fixtureInfo;

  final String? error;

  FixtureState({
    required this.isLoading,
    required this.fixture,
    required this.fixtureInfo,
    this.error,
  });

  factory FixtureState.initial() {
    return FixtureState(
      isLoading: false,
      fixtureInfo: [],
      fixture: [],
    );
  }

  FixtureState copyWith({
    bool? isLoading,
    List<FixtureEntity>? fixture,
    List<FixtureInfoEntity>? fixtureInfo,
    String? error,
  }) {
    return FixtureState(
      isLoading: isLoading ?? this.isLoading,
      fixture: fixture ?? this.fixture,
      fixtureInfo: fixtureInfo ?? this.fixtureInfo,
      error: error ?? this.error,
    );
  }
}
