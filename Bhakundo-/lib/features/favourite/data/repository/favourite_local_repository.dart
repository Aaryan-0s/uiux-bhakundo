import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/favourite/domain/entity/favourite_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repository/favourite_repository.dart';
import '../data_source/favourite_local_data_source.dart';

final favouriteLocalRepoProvider = Provider<IFavouriteRepository>((ref) {
  return FavouriteLocalRepositoryImpl(
    favouriteLocalDataSource: ref.read(favouriteLocalDataSourceProvider),
  );
});

class FavouriteLocalRepositoryImpl implements IFavouriteRepository {
  final FavouriteLocalDataSource favouriteLocalDataSource;

  FavouriteLocalRepositoryImpl({
    required this.favouriteLocalDataSource,
  });

  @override
  Future<Either<Failure, List<FavouriteEntity>>> addFavourite(
      FavouriteEntity favourite) {
    // TODO: implement addFavourite
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FavouriteEntity>>> getFavourite() {
    // TODO: implement getFavourite
    return favouriteLocalDataSource.getFavourite();
  }

  @override
  Future<Either<Failure, bool>> removeFavourite(String id) {
    // TODO: implement removeFavourite
    throw UnimplementedError();
  }
}
