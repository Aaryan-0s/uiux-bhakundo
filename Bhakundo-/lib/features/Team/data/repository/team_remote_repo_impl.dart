import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/team_entity.dart';
import '../../domain/repository/team_repository.dart';
import '../data_source/team_remote_data_source.dart';

final teamRemoteRepoProvider = Provider<ITeamRepository>(
  (ref) => TeamRemoteRepositoryImpl(
    teamRemoteDataSource: ref.read(teamRemoteDataSourceProvider),
  ),
);

class TeamRemoteRepositoryImpl implements ITeamRepository {
  final TeamRemoteDataSource teamRemoteDataSource;

  TeamRemoteRepositoryImpl({required this.teamRemoteDataSource});

  @override
  Future<Either<Failure, List<TeamEntity>>> getAllTeam(String id) {
    return teamRemoteDataSource.getAllTeam(id);
  }
}
