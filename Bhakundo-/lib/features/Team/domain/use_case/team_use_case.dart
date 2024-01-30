import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/team_entity.dart';
import '../repository/team_repository.dart';

final teamUsecaseProvider = Provider<TeamUseCase>(
  (ref) => TeamUseCase(
    teamRepository: ref.watch(teamRepositoryProvider),
  ),
);

class TeamUseCase {
  final ITeamRepository teamRepository;

  TeamUseCase({required this.teamRepository});

  Future<Either<Failure, List<TeamEntity>>> getAllTeam(String id) {
    return teamRepository.getAllTeam(id);
  }
}
