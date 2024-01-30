import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/favourite_entity.dart';
import '../repository/favourite_repository.dart';

final favouriteUsecaseProvider = Provider<FavouriteUseCase>(
  (ref) => FavouriteUseCase(
    favouriteRepository: ref.watch(favouriteRepositoryProvider),
  ),
);

class FavouriteUseCase {
  final IFavouriteRepository favouriteRepository;

  FavouriteUseCase({required this.favouriteRepository});

  Future<Either<Failure, List<FavouriteEntity>>> getFavourite() {
    return favouriteRepository.getFavourite();
  }

  Future<Either<Failure, List<FavouriteEntity>>> addFavourite(
      FavouriteEntity favourite) {
    return favouriteRepository.addFavourite(favourite);
  }

  Future<Either<Failure, bool>> removeFavourite(String id) {
    return favouriteRepository.removeFavourite(id);
  }
}
