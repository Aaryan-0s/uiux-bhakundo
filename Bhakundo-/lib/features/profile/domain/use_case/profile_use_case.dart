import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

final profileUsecaseProvider = Provider<ProfileUseCase>(
  (ref) => ProfileUseCase(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<Either<Failure, List<ProfileEntity>>> getProfile() {
    return profileRepository.getProfile();
  }

  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    return profileRepository.updateProfile(profile);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await profileRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> deleteProfile() async {
    return await profileRepository.deleteProfile();
  }
}
