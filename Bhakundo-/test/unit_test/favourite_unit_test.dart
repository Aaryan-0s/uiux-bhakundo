import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/features/favourite/domain/entity/favourite_entity.dart';
import 'package:nba_hub/features/favourite/domain/use_case/favourite_use_case.dart';
import 'package:nba_hub/features/favourite/presentation/viewmodel/favourite_profile_view_model.dart';

import '../../test_data/favourite_entity_test.dart';
import 'favourite_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FavouriteUseCase>(), MockSpec<BuildContext>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late FavouriteUseCase mockFavouriteUsecase;
  late List<FavouriteEntity> favouriteEntity;

  setUpAll(() async {
    mockFavouriteUsecase = MockFavouriteUseCase();
    favouriteEntity = await getFavouriteTest();
    when(mockFavouriteUsecase.getFavourite())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        favouriteViewModelProvider.overrideWith(
          (ref) => FavouriteViewModel(mockFavouriteUsecase),
        ),
      ],
    );
  });

  test('check favourite initial state', () async {
    await container.read(favouriteViewModelProvider.notifier).getfavourite();

    final favouriteState = container.read(favouriteViewModelProvider);

    expect(favouriteState.isLoading, false);
    expect(favouriteState.favourite, isEmpty);
  });

  test('should get favourite info', () async {
    when(mockFavouriteUsecase.getFavourite())
        .thenAnswer((_) => Future.value(Right(favouriteEntity)));

    await container.read(favouriteViewModelProvider.notifier).getfavourite();

    final favouriteState = container.read(favouriteViewModelProvider);

    expect(favouriteState.isLoading, false);
    expect(favouriteState.check.length, 5);
  });

  test('should not get the favourite info', () async {
    when(mockFavouriteUsecase.getFavourite())
        .thenAnswer((_) => Future.value(Right(favouriteEntity)));

    await container.read(favouriteViewModelProvider.notifier).getfavourite();

    final favouriteState = container.read(favouriteViewModelProvider);

    expect(favouriteState.isLoading, false);
    expect(favouriteState.check.length, 1);
  });

  tearDownAll(() {
    container.dispose();
  });
}
