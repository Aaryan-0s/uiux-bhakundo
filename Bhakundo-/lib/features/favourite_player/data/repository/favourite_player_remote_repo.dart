import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/common/provider/internet_connectivity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/favourite_entity.dart';
import '../../domain/repository/favourite_repository.dart';
import '../data_source/favourite_player_local_data_source.dart';
import '../data_source/favourite_player_remote_data_source.dart';

final favouritePlayerRemoteRepoProvider = Provider<IFavouritePlayerRepository>(
  (ref) => FavouritePlayerRemoteRepositoryImpl(
    favouritePlayerRemoteDataSource:
        ref.read(favouritePlayerRemoteDataSourceProvider),
    favouritePlayerLocalDataSource:
        ref.read(favouritePlayerLocalDataSourceProvider),
  ),
);

class FavouritePlayerRemoteRepositoryImpl
    implements IFavouritePlayerRepository {
  final FavouritePlayerRemoteDataSource favouritePlayerRemoteDataSource;
  final FavouritePlayerLocalDataSource favouritePlayerLocalDataSource;

  FavouritePlayerRemoteRepositoryImpl(
      {required this.favouritePlayerRemoteDataSource,
      required this.favouritePlayerLocalDataSource});

  @override
  Future<Either<Failure, List<FavouritePlayerEntity>>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer) {
    // TODO: implement addFavouritePlayer
    return favouritePlayerRemoteDataSource.addFavouritePlayer(favouritePlayer);
  }

  @override
  Future<Either<Failure, List<FavouritePlayerEntity>>>
      getFavouritePlayer() async {
    final a = await checkConnectivity();

    if (a) {
      print("game conneceted");
      return favouritePlayerRemoteDataSource.getFavouritePlayer();
    } else {
      print("game not conneceted");
      return favouritePlayerLocalDataSource.getFavouritePlayer();
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavouritePlayer(String id) {
    // TODO: implement removeFavouritePlayer
    return favouritePlayerRemoteDataSource.removeFavouritePlayer(id);
  }
}
