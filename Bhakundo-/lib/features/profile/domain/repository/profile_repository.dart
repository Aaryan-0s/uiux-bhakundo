import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_remote_repo_impl.dart';
import '../entity/profile_entity.dart';

final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
  // return ref.watch(standingLocalRepoProvider);
  // // Check for the internet

  return ref.watch(profileRemoteRepoProvider);
});

abstract class IProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getProfile();
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> deleteProfile();
}
