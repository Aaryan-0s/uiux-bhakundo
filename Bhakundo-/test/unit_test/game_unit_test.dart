import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/core/failure/failure.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';
import 'package:nba_hub/features/games/domain/use_case/game_use_case.dart';
import 'package:nba_hub/features/games/presentation/viewmodel/game_view_model.dart';

import '../../test_data/game_entity_test.dart';
import 'game_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GameUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late GameUseCase mockGameUsecase;
  late List<GameEntity> gameEntity;

  setUpAll(() async {
    mockGameUsecase = MockGameUseCase();
    gameEntity = await getGameListTest();
    when(mockGameUsecase.getAllGames())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        gameViewModelProvider.overrideWith(
          (ref) => GameViewModel(mockGameUsecase),
        ),
      ],
    );
  });

  test('check game initial state', () async {
    await container.read(gameViewModelProvider.notifier).getAllGames();

    final gameState = container.read(gameViewModelProvider);

    expect(gameState.isLoading, false);
    expect(gameState.games, isEmpty);
  });

  test('check for the list of gamees when calling getAllGamees', () async {
    when(mockGameUsecase.getAllGames())
        .thenAnswer((_) => Future.value(Right(gameEntity)));

    await container.read(gameViewModelProvider.notifier).getAllGames();

    final gameState = container.read(gameViewModelProvider);

    expect(gameState.isLoading, false);
    expect(gameState.games.length, 4);
  });

  test('check for the list of gamees when calling getAllGamees', () async {
    when(mockGameUsecase.getAllGames())
        .thenAnswer((_) => Future.value(Right(gameEntity)));

    await container.read(gameViewModelProvider.notifier).getAllGames();

    final gameState = container.read(gameViewModelProvider);

    expect(gameState.isLoading, false);
    expect(gameState.games.length, 5);
  });

  test('check for the error when calling getAllGamees', () async {
    when(mockGameUsecase.getAllGames())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Error'))));

    await container.read(gameViewModelProvider.notifier).getAllGames();

    final gameState = container.read(gameViewModelProvider);

    expect(gameState.isLoading, false);
    expect(gameState.error, 'Error');
  });

  tearDownAll(() {
    container.dispose();
  });
}
