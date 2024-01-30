import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/team_remote_repo_impl.dart';
import '../entity/team_entity.dart';

final teamRepositoryProvider = Provider<ITeamRepository>(
  (ref) {
    // return ref.watch(teamLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(teamRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(teamRemoteRepoProvider);
    }
  },
);

abstract class ITeamRepository {
  Future<Either<Failure, List<TeamEntity>>> getAllTeam(String id);
}
