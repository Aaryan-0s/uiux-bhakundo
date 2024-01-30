import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/standing_remote_repo_impl.dart';
import '../entity/standing_entity.dart';
import '../entity/standing_player_entity.dart';

final standingRepositoryProvider = Provider<IStandingRepository>(
  (ref) {
    // return ref.watch(standingLocalRepoProvider);
    // // Check for the internet

    return ref.watch(standingRemoteRepoProvider);
  },
);

abstract class IStandingRepository {
  Future<Either<Failure, List<StandingEntity>>> getAllStanding();
  Future<Either<Failure, List<StandingPlayerEntity>>> getAllStandingPlayer();
  Future<Either<Failure, List<StandingEntity>>> getStandingByTeamId(String id);
}
