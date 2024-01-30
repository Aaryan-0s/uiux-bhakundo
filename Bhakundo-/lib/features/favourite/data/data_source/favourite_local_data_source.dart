import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/favourite_entity.dart';
import '../model/favourite_hive_model.dart';

// Dependency Injection using Riverpod
final favouriteLocalDataSourceProvider =
    Provider<FavouriteLocalDataSource>((ref) {
  return FavouriteLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      favouriteHiveModel: ref.read(favouriteHiveModelProvider));
});

class FavouriteLocalDataSource {
  final HiveService hiveService;
  final FavouriteHiveModel favouriteHiveModel;

  FavouriteLocalDataSource({
    required this.hiveService,
    required this.favouriteHiveModel,
  });

  // Add Favourite
  Future<Either<Failure, bool>> addFavourite(FavouriteEntity favourite) async {
    try {
      // Convert Entity to Hive Object
      final hiveFavourite = favouriteHiveModel.toHiveModel(favourite);
      // Add to Hive
      await hiveService.addFavourite(hiveFavourite);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<FavouriteEntity>>> getFavourite() async {
    try {
      // Get all favouritees from Hive
      final favourites = await hiveService.getAllFavourite();
      // Convert Hive Object to Entity
      final favouriteEntities = favouriteHiveModel.toEntityList(favourites);
      return Right(favouriteEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
