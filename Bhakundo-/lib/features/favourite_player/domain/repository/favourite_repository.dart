import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/favourite_player_remote_repo.dart';
import '../entity/favourite_entity.dart';

final favouritePlayerRepositoryProvider = Provider<IFavouritePlayerRepository>(
  (ref) {
    // return ref.watch(standingLocalRepoProvider);
    // // Check for the internet
    return ref.watch(favouritePlayerRemoteRepoProvider);
  },
);

abstract class IFavouritePlayerRepository {
  Future<Either<Failure, List<FavouritePlayerEntity>>> getFavouritePlayer();
  Future<Either<Failure, List<FavouritePlayerEntity>>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer);
  Future<Either<Failure, bool>> removeFavouritePlayer(String id);
}
