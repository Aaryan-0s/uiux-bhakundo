import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/use_case/profile_use_case.dart';
import '../state/profile_state.dart';

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, bool>(
  (ref) => ProfileViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

final profileInfoViewModelProvider =
    StateNotifierProvider<ProfileInfoViewModel, ProfileState>(
  (ref) {
    return ProfileInfoViewModel(ref.read(profileUsecaseProvider));
  },
);

class ProfileViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  ProfileViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    showSnackBar(
        message: 'Logging out....', context: context, color: Colors.red);

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute,
        (route) => false,
      );
    });
  }
}

class ProfileInfoViewModel extends StateNotifier<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileInfoViewModel(this.profileUseCase) : super(ProfileState.initial()) {
    getProfile();
  }

  getProfile() async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.getProfile();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, profiles: r, error: null),
    );
  }
}
