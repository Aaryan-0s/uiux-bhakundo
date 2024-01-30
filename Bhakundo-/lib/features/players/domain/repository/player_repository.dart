import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/player_remote_repo_impl.dart';
import '../entity/player_entity.dart';

final playerRepositoryProvider = Provider<IPlayerRepository>(
  (ref) {
    // return ref.watch(playerLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(playerRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(playerRemoteRepoProvider);
    }
  },
);

abstract class IPlayerRepository {
  Future<Either<Failure, List<PlayerEntity>>> getAllPlayer(String id);
  Future<Either<Failure, List<PlayerEntity>>> getAllPlayerById(String id);
}
