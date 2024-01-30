import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/favourite_entity.dart';
import '../../domain/repository/favourite_repository.dart';
import '../data_source/favourite_player_local_data_source.dart';

final favouritePlayerLocalRepoProvider =
    Provider<IFavouritePlayerRepository>((ref) {
  return FavouritePlayerLocalRepositoryImpl(
    favouritePlayerLocalDataSource:
        ref.read(favouritePlayerLocalDataSourceProvider),
  );
});

class FavouritePlayerLocalRepositoryImpl implements IFavouritePlayerRepository {
  final FavouritePlayerLocalDataSource favouritePlayerLocalDataSource;

  FavouritePlayerLocalRepositoryImpl({
    required this.favouritePlayerLocalDataSource,
  });

  @override
  Future<Either<Failure, List<FavouritePlayerEntity>>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer) {
    // TODO: implement addFavouritePlayer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FavouritePlayerEntity>>> getFavouritePlayer() {
    // TODO: implement getFavouritePlayer
    return favouritePlayerLocalDataSource.getFavouritePlayer();
  }

  @override
  Future<Either<Failure, bool>> removeFavouritePlayer(String id) {
    // TODO: implement removeFavouritePlayer
    throw UnimplementedError();
  }
}
