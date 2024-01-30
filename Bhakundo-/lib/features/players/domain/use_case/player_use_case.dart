import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/player_entity.dart';
import '../repository/player_repository.dart';

final playerUsecaseProvider = Provider<PlayerUseCase>(
  (ref) => PlayerUseCase(
    playerRepository: ref.watch(playerRepositoryProvider),
  ),
);

class PlayerUseCase {
  final IPlayerRepository playerRepository;

  PlayerUseCase({required this.playerRepository});

  Future<Either<Failure, List<PlayerEntity>>> getAllPlayer(String id) {
    return playerRepository.getAllPlayer(id);
  }

  Future<Either<Failure, List<PlayerEntity>>> getAllPlayerById(String id) {
    return playerRepository.getAllPlayerById(id);
  }
}
