import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/favourite_remote_repo.dart';
import '../entity/favourite_entity.dart';

final favouriteRepositoryProvider = Provider<IFavouriteRepository>(
  (ref) {
    // return ref.watch(standingLocalRepoProvider);
    // // Check for the internet

    // If internet is available then return remote repo

    return ref.watch(favouriteRemoteRepoProvider);
  },
);

abstract class IFavouriteRepository {
  Future<Either<Failure, List<FavouriteEntity>>> getFavourite();
  Future<Either<Failure, List<FavouriteEntity>>> addFavourite(
      FavouriteEntity favourite);
  Future<Either<Failure, bool>> removeFavourite(String id);
}
