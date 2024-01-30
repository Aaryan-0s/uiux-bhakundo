import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:integration_test/integration_test.dart";
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/config/router/app_route.dart';
import 'package:nba_hub/features/auth/domain/use_case/auth_usecase.dart';
import 'package:nba_hub/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../test/unit_test/auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUsecase;

  //we are doing this for dashboard

  late bool isLogin;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();

    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockAuthUsecase.loginUser('aaryan', 'aaryan'))
        .thenAnswer((_) async => Right(isLogin));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'aaryan');
    await tester.enterText(find.byType(TextFormField).at(1), 'aaryan');

    await tester.tap(
      find.widgetWithText(
        ElevatedButton,
        'Login',
      ),
    );

    await tester.pump();
    print("hello");

    // Dismiss existing SnackBars, if any.
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.widgetWithText(SnackBar, 'Login Success'), findsOneWidget);
    // expect(find.text('No games for today'), findsOneWidget);
    // expect(find.text('No games for today'), findsOneWidget);
  });
}
