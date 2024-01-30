import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/config/themes/app_theme.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';
import 'package:nba_hub/features/profile/domain/use_case/profile_use_case.dart';
import 'package:nba_hub/features/profile/presentation/viewmodel/profile_view_model.dart';

import '../test/unit_test/profile_unit_test.mocks.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileUseCase mockProfileUseCase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUseCase = MockProfileUseCase();
    profileEntity = await getProfileTest();
  });

  testWidgets('Profile View pass', (tester) async {
    when(mockProfileUseCase.getProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileInfoViewModelProvider
              .overrideWith((ref) => ProfileInfoViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.profile,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getApplicationTheme(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("aaryan"), findsOneWidget);
  });
  testWidgets('Profile View fail', (tester) async {
    when(mockProfileUseCase.getProfile())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileInfoViewModelProvider
              .overrideWith((ref) => ProfileInfoViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.profile,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getApplicationTheme(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("aaryanasd"), findsOneWidget);
  });

  // testWidgets('Profile View fail', (tester) async {
  //   when(mockProfileUseCase.getProfile())
  //       .thenAnswer((_) async => Left(Failure(error: "Invalid")));

  //   await tester.pumpWidget(
  //     ProviderScope(
  //       overrides: [
  //         profileInfoViewModelProvider
  //             .overrideWith((ref) => ProfileInfoViewModel(mockProfileUseCase)),
  //       ],
  //       child: MaterialApp(
  //         routes: AppRoute.getApplicationRoute(),
  //         initialRoute: AppRoute.profile,
  //         debugShowCheckedModeBanner: false,
  //         theme: AppTheme.getApplicationTheme(),
  //       ),
  //     ),
  //   );

  //   await tester.pumpAndSettle();
  //   expect(find.text("aaryan"), findsOneWidget);

  //   // final textButtonFinder = find.byType(ProfileMenuWidget);
  //   // expect(textButtonFinder, findsNWidgets(3));
  // });
}
