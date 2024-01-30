import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/game_remote_repo_impl.dart';

final gameRepositoryProvider = Provider<IGameRepository>(
  (ref) {
    // return ref.watch(standingLocalRepoProvider);
    // // Check for the internet
    return ref.watch(gameRemoteRepoProvider);
  },
);

abstract class IGameRepository {
  Future<Either<Failure, List<GameEntity>>> getAllGames();
  Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
      String season, String date);
}
