import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/failure/failure.dart';
import 'package:nba_hub/features/games/data/data_source/game_local_data_source.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';
import 'package:nba_hub/features/games/domain/repository/game_repository.dart';

final gameLocalRepoProvider = Provider<IGameRepository>((ref) {
  return GameLocalRepositoryImpl(
    gameLocalDataSource: ref.read(gameLocalDataSourceProvider),
  );
});

class GameLocalRepositoryImpl implements IGameRepository {
  final GameLocalDataSource gameLocalDataSource;

  GameLocalRepositoryImpl({
    required this.gameLocalDataSource,
  });

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() {
    return gameLocalDataSource.getAllGames();
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
      String season, String date) {
    throw UnimplementedError();
  }
}
