import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';
import 'package:nba_hub/features/profile/domain/use_case/profile_use_case.dart';
import 'package:nba_hub/features/profile/presentation/viewmodel/profile_view_model.dart';

import '../../test_data/profile_entity_test.dart';
import 'profile_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileUseCase>(), MockSpec<BuildContext>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late ProfileUseCase mockProfileUsecase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUsecase = MockProfileUseCase();
    profileEntity = await getProfileTest();
    when(mockProfileUsecase.getProfile())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        profileInfoViewModelProvider.overrideWith(
          (ref) => ProfileInfoViewModel(mockProfileUsecase),
        ),
      ],
    );
  });

  test('check profile initial state', () async {
    await container.read(profileInfoViewModelProvider.notifier).getProfile();

    final profileState = container.read(profileInfoViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.profile, isEmpty);
  });

  test('should get profile info', () async {
    when(mockProfileUsecase.getProfile())
        .thenAnswer((_) => Future.value(Right(profileEntity)));

    await container.read(profileInfoViewModelProvider.notifier).getProfile();

    final profileState = container.read(profileInfoViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.profile.length, 1);
  });

  test('should not get the profile info', () async {
    when(mockProfileUsecase.getProfile())
        .thenAnswer((_) => Future.value(Right(profileEntity)));

    await container.read(profileInfoViewModelProvider.notifier).getProfile();

    final profileState = container.read(profileInfoViewModelProvider);

    expect(profileState.isLoading, false);
    expect(profileState.profile.length, 5);
  });

  tearDownAll(() {
    container.dispose();
  });
}
