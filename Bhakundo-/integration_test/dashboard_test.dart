import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';
import 'package:nba_hub/features/games/domain/use_case/game_use_case.dart';
import 'package:nba_hub/features/games/presentation/viewmodel/game_view_model.dart';

import '../test/unit_test/game_unit_test.mocks.dart';
import '../test_data/game_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late GameUseCase mockGameUsecase;

  late List<GameEntity> gameEntity;

  setUpAll(() async {
    mockGameUsecase = MockGameUseCase();

    gameEntity = await getGameListTest();
  });

  testWidgets(
    'dashboard view ...',
    (tester) async {
      when(mockGameUsecase.getAllGames())
          .thenAnswer((_) async => Right(gameEntity));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            gameViewModelProvider
                .overrideWith((ref) => GameViewModel(mockGameUsecase)),
          ],
          child: MaterialApp(
            routes: AppRoute.getApplicationRoute(),
            initialRoute: AppRoute.dashBoardRoute,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsWidgets);
      final listViewWidgets =
          tester.widgetList<ListView>(find.byType(ListView));

      final itemCounts = listViewWidgets
          .map((listView) => listView.childrenDelegate.estimatedChildCount ?? 0)
          .toList();

      print(itemCounts.length);

      expect(itemCounts.length, 1);
      expect(itemCounts[0], gameEntity.length);
    },
  );
}
