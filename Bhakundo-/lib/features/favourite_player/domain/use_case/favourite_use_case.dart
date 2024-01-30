import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/favourite_entity.dart';
import '../repository/favourite_repository.dart';

final favouritePlayerUsecaseProvider = Provider<FavouritePlayerUseCase>(
  (ref) => FavouritePlayerUseCase(
    favouritePlayerRepository: ref.watch(favouritePlayerRepositoryProvider),
  ),
);

class FavouritePlayerUseCase {
  final IFavouritePlayerRepository favouritePlayerRepository;

  FavouritePlayerUseCase({required this.favouritePlayerRepository});

  Future<Either<Failure, List<FavouritePlayerEntity>>> getFavouritePlayer() {
    return favouritePlayerRepository.getFavouritePlayer();
  }

  Future<Either<Failure, List<FavouritePlayerEntity>>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer) {
    return favouritePlayerRepository.addFavouritePlayer(favouritePlayer);
  }

  Future<Either<Failure, bool>> removeFavouritePlayer(String id) {
    return favouritePlayerRepository.removeFavouritePlayer(id);
  }
}
