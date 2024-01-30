import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/fixture_remote_repo_impl.dart';
import '../entity/fixture_entity.dart';
import '../entity/fixture_info_entity.dart';

final fixtureRepositoryProvider = Provider<IFixtureRepository>(
  (ref) {
    // return ref.watch(standingLocalRepoProvider);
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      print("connected");
      return ref.watch(fixtureRemoteRepoProvider);
    } else {
      print("not connected");
      // If internet is not available then return local repo
      return ref.watch(fixtureRemoteRepoProvider);
    }
  },
);

abstract class IFixtureRepository {
  Future<Either<Failure, List<FixtureEntity>>> getFixtureById(String id);
  Future<Either<Failure, List<FixtureInfoEntity>>> getFixtureInfo(String id);
}
