import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_player_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/standing_entity.dart';
import '../../domain/repository/standing_repository.dart';
import '../data_source/standing_local_data_source.dart';

final standingLocalRepoProvider = Provider<IStandingRepository>((ref) {
  return StandingLocalRepositoryImpl(
    standingLocalDataSource: ref.read(standingLocalDataSourceProvider),
  );
});

class StandingLocalRepositoryImpl implements IStandingRepository {
  final StandingLocalDataSource standingLocalDataSource;

  StandingLocalRepositoryImpl({
    required this.standingLocalDataSource,
  });

  @override
  Future<Either<Failure, List<StandingEntity>>> getAllStanding() {
    return standingLocalDataSource.getAllStandings();
  }

  @override
  Future<Either<Failure, List<StandingPlayerEntity>>> getAllStandingPlayer() {
    return standingLocalDataSource.getAllStandingPlayer();
  }

  @override
  Future<Either<Failure, List<StandingEntity>>> getStandingByTeamId(String id) {
    throw UnimplementedError();
  }
}
