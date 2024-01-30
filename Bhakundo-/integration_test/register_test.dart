import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// import integration_test\register_test.dart

import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/features/auth/domain/entity/auth_entity.dart';
import 'package:nba_hub/features/auth/domain/use_case/auth_usecase.dart';
import 'package:nba_hub/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../test/unit_test/auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late AuthEntity authEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      authEntity = const AuthEntity(
          fname: 'aaryan',
          lname: 'aaryan',
          email: 'aaryan',
          image: '',
          password: 'aaryan',
          username: 'aaryan');
    },
  );

  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.signUpRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Enter kiran in first textform field
    await tester.enterText(find.byType(TextFormField).at(0), 'aaryan');
    // Enter kiran123 in second textform field
    await tester.enterText(find.byType(TextFormField).at(1), 'aaryan');
    // Enter phone no
    await tester.enterText(find.byType(TextFormField).at(2), 'aaryan');
    // Enter username
    await tester.enterText(find.byType(TextFormField).at(3), 'aaryan');
    // Enter password
    await tester.enterText(find.byType(TextFormField).at(4), 'aaryan');

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(196.4, 734.3), // delta to move
    );

    await tester.tap(registerButtonFinder);

    await tester.pump();

    // Check weather the snackbar is displayed or not
    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);
    // expect(find.text('SIGN IN'), findsOneWidget);
  });
}
