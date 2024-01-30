import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/standing_entity.dart';
import '../entity/standing_player_entity.dart';
import '../repository/standing_repository.dart';

final standingUsecaseProvider = Provider<StandingUseCase>(
  (ref) => StandingUseCase(
    standingRepository: ref.watch(standingRepositoryProvider),
  ),
);

class StandingUseCase {
  final IStandingRepository standingRepository;

  StandingUseCase({required this.standingRepository});

  Future<Either<Failure, List<StandingEntity>>> getAllStanding() {
    return standingRepository.getAllStanding();
  }

  Future<Either<Failure, List<StandingPlayerEntity>>> getAllStandingPlayer() {
    return standingRepository.getAllStandingPlayer();
  }

  Future<Either<Failure, List<StandingEntity>>> getStandingByTeamId(String id) {
    return standingRepository.getStandingByTeamId(id);
  }
}
