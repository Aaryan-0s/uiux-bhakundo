import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/player_entity.dart';
import '../../domain/repository/player_repository.dart';
import '../data_source/player_remote_data_source.dart';

final playerRemoteRepoProvider = Provider<IPlayerRepository>(
  (ref) => PlayerRemoteRepositoryImpl(
    playerRemoteDataSource: ref.read(playerRemoteDataSourceProvider),
  ),
);

class PlayerRemoteRepositoryImpl implements IPlayerRepository {
  final PlayerRemoteDataSource playerRemoteDataSource;

  PlayerRemoteRepositoryImpl({required this.playerRemoteDataSource});

  @override
  Future<Either<Failure, List<PlayerEntity>>> getAllPlayer(String id) {
    return playerRemoteDataSource.getAllPlayer(id);
  }

  @override
  Future<Either<Failure, List<PlayerEntity>>> getAllPlayerById(String id) {
    return playerRemoteDataSource.getAllPlayerById(id);
  }
}
