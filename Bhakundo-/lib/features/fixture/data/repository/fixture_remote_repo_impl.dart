import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/fixture_entity.dart';
import '../../domain/entity/fixture_info_entity.dart';
import '../../domain/repository/fixture_repository.dart';
import '../data_source/fixture_remote_data_source.dart';

final fixtureRemoteRepoProvider = Provider<IFixtureRepository>(
  (ref) => FixtureRemoteRepositoryImpl(
    fixtureRemoteDataSource: ref.read(fixtureRemoteDataSourceProvider),
  ),
);

class FixtureRemoteRepositoryImpl implements IFixtureRepository {
  final FixtureRemoteDataSource fixtureRemoteDataSource;

  FixtureRemoteRepositoryImpl({required this.fixtureRemoteDataSource});

  @override
  Future<Either<Failure, List<FixtureEntity>>> getFixtureById(String id) {
    return fixtureRemoteDataSource.getFixtureById(id);
  }

  @override
  Future<Either<Failure, List<FixtureInfoEntity>>> getFixtureInfo(String id) {
    return fixtureRemoteDataSource.getFixtureInfo(id);
  }
}
