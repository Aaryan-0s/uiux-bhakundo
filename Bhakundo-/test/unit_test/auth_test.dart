import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nba_hub/core/failure/failure.dart';
import 'package:nba_hub/features/auth/domain/entity/auth_entity.dart';
import 'package:nba_hub/features/auth/domain/use_case/auth_usecase.dart';
import 'package:nba_hub/features/auth/presentation/viewmodel/auth_view_model.dart';

import 'auth_test.mocks.dart';

//dart run build_runner build --delete-conflicting-outputs

@GenerateNiceMocks([MockSpec<AuthUseCase>(), MockSpec<BuildContext>()])
void main() {
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late BuildContext context;
  late AuthEntity authEntity;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    context = MockBuildContext();
    authEntity = const AuthEntity(
        fname: "aaryan",
        lname: "basnet",
        email: "aaryan@gmail.com",
        username: "aaryan",
        password: "aaryan");
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(mockAuthUsecase),
      ),
    ]);
  });

  test('check for inital state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
  });

  test('login test with valid username and password', () async {
    when(mockAuthUsecase.loginUser('aaryan', 'aaryan'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'aaryan', 'aaryan');

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('login test with invalid username and password', () async {
    when(mockAuthUsecase.loginUser('aaryan', 'aaryan'))
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'aaryan123', "aaryan123");

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNotNull);
  });

  test('register  test with valid username and password', () async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container.read(authViewModelProvider.notifier).registerUser(
        const AuthEntity(
            fname: "aaryan",
            lname: "basnet",
            email: "aaryan@gmail.com",
            username: "aaryan",
            password: "aaryan"));

    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('register test with invalid username and password', () async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) => Future.value(Left(Failure(error: "Invalid"))));

    await container.read(authViewModelProvider.notifier).registerUser(
        const AuthEntity(
            fname: "aaryan123",
            lname: "basnet",
            email: "aaryan@gmail.com",
            username: "aaryan",
            password: "aaryan"));

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNotNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}
