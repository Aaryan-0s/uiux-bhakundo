import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/fixture_entity.dart';
import '../entity/fixture_info_entity.dart';
import '../repository/fixture_repository.dart';

final fixtureUsecaseProvider = Provider<FixtureUseCase>(
  (ref) => FixtureUseCase(
    fixtureRepository: ref.watch(fixtureRepositoryProvider),
  ),
);

class FixtureUseCase {
  final IFixtureRepository fixtureRepository;

  FixtureUseCase({required this.fixtureRepository});

  Future<Either<Failure, List<FixtureEntity>>> getFixtureById(
    String id,
  ) {
    return fixtureRepository.getFixtureById(id);
  }

  Future<Either<Failure, List<FixtureInfoEntity>>> getFixtureInfo(
    String id,
  ) {
    return fixtureRepository.getFixtureInfo(id);
  }
}
