import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repository/game_repository.dart';

final gameUsecaseProvider = Provider<GameUseCase>(
  (ref) => GameUseCase(
    gameRepository: ref.watch(gameRepositoryProvider),
  ),
);

class GameUseCase {
  final IGameRepository gameRepository;

  GameUseCase({required this.gameRepository});

  Future<Either<Failure, List<GameEntity>>> getAllGames() {
    return gameRepository.getAllGames();
  }

  Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
    String season,
    String date,
  ) {
    return gameRepository.getAllGameByDate(season, date);
  }
}
