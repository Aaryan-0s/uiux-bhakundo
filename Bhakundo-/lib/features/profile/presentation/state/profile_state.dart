import '../../domain/entity/profile_entity.dart';

class ProfileState {
  final bool isLoading;
  final List<ProfileEntity> profile;

  final String? error;
  final dynamic imageName;

  ProfileState({
    required this.isLoading,
    required this.profile,
    this.error,
    this.imageName,
  });

  factory ProfileState.initial() {
    return ProfileState(
        isLoading: false, profile: [], error: null, imageName: "");
  }

  ProfileState copyWith({
    bool? isLoading,
    List<ProfileEntity>? profiles,
    String? error,
    dynamic imageName,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profiles ?? profile,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
