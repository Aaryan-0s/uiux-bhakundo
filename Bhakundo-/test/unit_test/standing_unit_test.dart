import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_entity.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_player_entity.dart';
import 'package:nba_hub/features/standing/domain/use_case/standing_use_case.dart';
import 'package:nba_hub/features/standing/presentation/viewmodel/standing_view_model.dart';

import '../../test_data/standing_entity_test.dart';
import '../../test_data/standing_player_entity_test.dart';
import 'standing_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StandingUseCase>(), MockSpec<BuildContext>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late StandingUseCase mockStandingUsecase;
  late List<StandingEntity> standingEntity;
  late List<StandingPlayerEntity> standingPlayerEntity;

  setUpAll(() async {
    mockStandingUsecase = MockStandingUseCase();
    standingEntity = await getAllStandingTest();
    standingPlayerEntity = await getAllStandingPlayerTest();
    when(mockStandingUsecase.getAllStanding())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        standingViewModelProvider.overrideWith(
          (ref) => StandingViewModel(mockStandingUsecase),
        ),
      ],
    );
    when(mockStandingUsecase.getAllStandingPlayer())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        standingViewModelProvider.overrideWith(
          (ref) => StandingViewModel(mockStandingUsecase),
        ),
      ],
    );
  });

  test('check standing initial state', () async {
    await container.read(standingViewModelProvider.notifier).getAllStanding();

    final standingState = container.read(standingViewModelProvider);

    expect(standingState.isLoading, false);
    expect(standingState.standing, isEmpty);
    expect(standingState.standingPlayer, isEmpty);
  });

  test('should get standingTeam info', () async {
    when(mockStandingUsecase.getAllStanding())
        .thenAnswer((_) => Future.value(Right(standingEntity)));

    await container.read(standingViewModelProvider.notifier).getAllStanding();

    final standingState = container.read(standingViewModelProvider);

    expect(standingState.isLoading, false);
    expect(standingState.standing.length, 18);
  });

  test('should get standingPlayer info', () async {
    when(mockStandingUsecase.getAllStandingPlayer())
        .thenAnswer((_) => Future.value(Right(standingPlayerEntity)));

    await container
        .read(standingViewModelProvider.notifier)
        .getAllStandingPlayer();

    final standingState = container.read(standingViewModelProvider);

    expect(standingState.isLoading, false);
    expect(standingState.standingPlayer.length, 2);
  });
  test('shouldnot get standingPlayer info', () async {
    when(mockStandingUsecase.getAllStandingPlayer())
        .thenAnswer((_) => Future.value(Right(standingPlayerEntity)));

    await container
        .read(standingViewModelProvider.notifier)
        .getAllStandingPlayer();

    final standingState = container.read(standingViewModelProvider);

    expect(standingState.isLoading, false);
    expect(standingState.standingPlayer.length, 20);
  });

  test('should not get the standing info', () async {
    when(mockStandingUsecase.getAllStanding())
        .thenAnswer((_) => Future.value(Right(standingEntity)));

    await container.read(standingViewModelProvider.notifier).getAllStanding();

    final standingState = container.read(standingViewModelProvider);

    expect(standingState.isLoading, false);
    expect(standingState.standing.length, 10);
  });

  tearDownAll(() {
    container.dispose();
  });

  tearDownAll(() {
    container.dispose();
  });
}
