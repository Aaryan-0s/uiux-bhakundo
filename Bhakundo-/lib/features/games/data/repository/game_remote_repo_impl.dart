import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/common/provider/internet_connectivity.dart';
import 'package:nba_hub/features/games/data/data_source/game_local_data_source.dart';
import 'package:nba_hub/features/games/data/data_source/game_remote_data_source.dart';
import 'package:nba_hub/features/games/domain/repository/game_repository.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/game_entity.dart';

final gameRemoteRepoProvider = Provider<IGameRepository>(
  (ref) => GameRemoteRepositoryImpl(
    gameRemoteDataSource: ref.read(gameRemoteDataSourceProvider),
    gameLocalDataSource: ref.read(gameLocalDataSourceProvider),
  ),
);

class GameRemoteRepositoryImpl implements IGameRepository {
  final GameRemoteDataSource gameRemoteDataSource;
  final GameLocalDataSource gameLocalDataSource;

  GameRemoteRepositoryImpl(
      {required this.gameRemoteDataSource, required this.gameLocalDataSource});

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGames() async {
    final a = await checkConnectivity();

    if (a) {
      print("game conneceted");
      return await gameRemoteDataSource.getAllGames();
    } else {
      print("game not conneceted");
      return gameLocalDataSource.getAllGames();
    }
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
      String season, String date) {
    return gameRemoteDataSource.getAllGameByDate(season, date);
  }
}
