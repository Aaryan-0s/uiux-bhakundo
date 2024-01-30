import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/config/themes/app_theme.dart';
import 'package:nba_hub/features/favourite/domain/entity/favourite_entity.dart';
import 'package:nba_hub/features/favourite/domain/use_case/favourite_use_case.dart';
import 'package:nba_hub/features/favourite/presentation/viewmodel/favourite_profile_view_model.dart';

import '../test/unit_test/favourite_unit_test.mocks.dart';
import '../test_data/favourite_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late FavouriteUseCase mockFavouriteUseCase;
  late List<FavouriteEntity> favouriteEntity;

  setUpAll(() async {
    mockFavouriteUseCase = MockFavouriteUseCase();
    favouriteEntity = await getFavouriteTest();
  });

  testWidgets('Favourite View pass', (tester) async {
    when(mockFavouriteUseCase.getFavourite())
        .thenAnswer((_) async => Right(favouriteEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favouriteViewModelProvider
              .overrideWith((ref) => FavouriteViewModel(mockFavouriteUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.favourite,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getApplicationTheme(),
        ),
      ),
    );

    await tester
        .pumpAndSettle(); // Wait for all asynchronous operations to complete.

    // Now you can perform your assertions.
    expect(find.byType(ListView), findsWidgets);
    final listViewWidgets = tester.widgetList<ListView>(find.byType(ListView));
    final itemCounts = listViewWidgets
        .map((listView) => listView.childrenDelegate.estimatedChildCount ?? 0)
        .toList();

    expect(itemCounts.length, 1);
    expect(itemCounts[0], favouriteEntity.length);
  });

  testWidgets('Favourite View fail', (tester) async {
    when(mockFavouriteUseCase.getFavourite())
        .thenAnswer((_) async => const Right([]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favouriteViewModelProvider
              .overrideWith((ref) => FavouriteViewModel(mockFavouriteUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.favourite,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getApplicationTheme(),
        ),
      ),
    );

    await tester
        .pumpAndSettle(); // Wait for all asynchronous operations to complete.

    // Now you can perform your assertions.
    expect(find.text('No teams in favourite'), findsOneWidget);
  });
}
