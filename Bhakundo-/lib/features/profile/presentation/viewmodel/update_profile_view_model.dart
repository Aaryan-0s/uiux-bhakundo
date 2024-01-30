import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/profile_entity.dart';
import '../../domain/use_case/profile_use_case.dart';
import '../state/profile_state.dart';

final updateProfileViewModelProvider =
    StateNotifierProvider<UpdateProfileViewModel, ProfileState>(
  (ref) => UpdateProfileViewModel(ref.read(profileUsecaseProvider)),
);

class UpdateProfileViewModel extends StateNotifier<ProfileState> {
  final ProfileUseCase profileUseCase;

  UpdateProfileViewModel(this.profileUseCase) : super(ProfileState.initial());

  updateProfile(ProfileEntity profile) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.updateProfile(profile);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> deleteProfile() async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.deleteProfile();
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}
