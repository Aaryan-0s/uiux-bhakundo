import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/common/provider/internet_connectivity.dart';
import 'package:nba_hub/features/favourite/data/data_source/favourite_local_data_source.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/favourite_entity.dart';
import '../../domain/repository/favourite_repository.dart';
import '../data_source/favourite_remote_data_source.dart';

final favouriteRemoteRepoProvider = Provider<IFavouriteRepository>(
  (ref) => FavouriteRemoteRepositoryImpl(
    favouriteRemoteDataSource: ref.read(favouriteRemoteDataSourceProvider),
    favouriteLocalDataSource: ref.read(favouriteLocalDataSourceProvider),
  ),
);

class FavouriteRemoteRepositoryImpl implements IFavouriteRepository {
  final FavouriteRemoteDataSource favouriteRemoteDataSource;
  final FavouriteLocalDataSource favouriteLocalDataSource;

  FavouriteRemoteRepositoryImpl(
      {required this.favouriteRemoteDataSource,
      required this.favouriteLocalDataSource});

  @override
  Future<Either<Failure, List<FavouriteEntity>>> addFavourite(
      FavouriteEntity favourite) {
    // TODO: implement addFavourite
    return favouriteRemoteDataSource.addFavourite(favourite);
  }

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourite() async {
    // TODO: implement getFavourite

    final a = await checkConnectivity();

    if (a) {
      print("game conneceted");
      return favouriteRemoteDataSource.getFavourite();
    } else {
      print("game not conneceted");
      return favouriteLocalDataSource.getFavourite();
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavourite(String id) {
    // TODO: implement removeFavourite
    return favouriteRemoteDataSource.removeFavourite(id);
  }
}
