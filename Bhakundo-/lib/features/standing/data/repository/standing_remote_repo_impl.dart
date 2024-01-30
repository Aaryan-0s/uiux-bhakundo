import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/core/common/provider/internet_connectivity.dart';
import 'package:nba_hub/features/standing/data/data_source/standing_local_data_source.dart';
import 'package:nba_hub/features/standing/domain/entity/standing_player_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/standing_entity.dart';
import '../../domain/repository/standing_repository.dart';
import '../data_source/standing_remote_data_source.dart';

final standingRemoteRepoProvider = Provider<IStandingRepository>(
  (ref) => StandingRemoteRepositoryImpl(
    standingRemoteDataSource: ref.read(standingRemoteDataSourceProvider),
    standingLocalDataSource: ref.read(standingLocalDataSourceProvider),
  ),
);

class StandingRemoteRepositoryImpl implements IStandingRepository {
  final StandingRemoteDataSource standingRemoteDataSource;
  final StandingLocalDataSource standingLocalDataSource;

  StandingRemoteRepositoryImpl(
      {required this.standingRemoteDataSource,
      required this.standingLocalDataSource});

  @override
  Future<Either<Failure, List<StandingEntity>>> getAllStanding() async {
    final a = await checkConnectivity();

    if (a) {
      return standingRemoteDataSource.getAllStanding();
    } else {
      print("game not conneceted");
      return standingLocalDataSource.getAllStandings();
    }
  }

  @override
  Future<Either<Failure, List<StandingPlayerEntity>>>
      getAllStandingPlayer() async {
    final a = await checkConnectivity();

    if (a) {
      return standingRemoteDataSource.getAllStandingPlayer();
    } else {
      print("game not conneceted");
      return standingLocalDataSource.getAllStandingPlayer();
    }
  }

  @override
  Future<Either<Failure, List<StandingEntity>>> getStandingByTeamId(String id) {
    return standingRemoteDataSource.getStandingByTeamId(id);
  }
}
