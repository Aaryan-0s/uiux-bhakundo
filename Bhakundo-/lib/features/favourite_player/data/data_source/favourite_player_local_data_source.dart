import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/favourite_entity.dart';
import '../model/favourite_player_hive_model.dart';

// Dependency Injection using Riverpod
final favouritePlayerLocalDataSourceProvider =
    Provider<FavouritePlayerLocalDataSource>((ref) {
  return FavouritePlayerLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      favouritePlayerHiveModel: ref.read(favouritePlayerHiveModelProvider));
});

class FavouritePlayerLocalDataSource {
  final HiveService hiveService;
  final FavouritePlayerHiveModel favouritePlayerHiveModel;

  FavouritePlayerLocalDataSource({
    required this.hiveService,
    required this.favouritePlayerHiveModel,
  });

  // Add FavouritePlayer
  Future<Either<Failure, bool>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer) async {
    try {
      // Convert Entity to Hive Object
      final hiveFavouritePlayer =
          favouritePlayerHiveModel.toHiveModel(favouritePlayer);
      // Add to Hive
      await hiveService.addFavouritePlayer(hiveFavouritePlayer);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<FavouritePlayerEntity>>>
      getFavouritePlayer() async {
    try {
      // Get all favouritePlayeres from Hive
      final favouritePlayers = await hiveService.getAllFavouritePlayer();
      // Convert Hive Object to Entity
      final favouritePlayerEntities =
          favouritePlayerHiveModel.toEntityList(favouritePlayers);
      return Right(favouritePlayerEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
