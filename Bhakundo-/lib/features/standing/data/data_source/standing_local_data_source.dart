import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/local/hive_service.dart';
import '../../domain/entity/standing_entity.dart';
import '../../domain/entity/standing_player_entity.dart';
import '../model/standing_hive_model.dart';
import '../model/standing_player_hive_model.dart';

// Dependency Injection using Riverpod
final standingLocalDataSourceProvider =
    Provider<StandingLocalDataSource>((ref) {
  return StandingLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      standingHiveModel: ref.read(standingHiveModelProvider),
      standingPlayerHiveModel: ref.read(standingPlayerHiveModelProvider));
});

class StandingLocalDataSource {
  final HiveService hiveService;
  final StandingHiveModel standingHiveModel;
  final StandingPlayerHiveModel standingPlayerHiveModel;

  StandingLocalDataSource(
      {required this.hiveService,
      required this.standingHiveModel,
      required this.standingPlayerHiveModel});

  // Add Standing
  Future<Either<Failure, bool>> addStanding(StandingEntity standing) async {
    try {
      // Convert Entity to Hive Object
      final hiveStanding = standingHiveModel.toHiveModel(standing);
      // Add to Hive
      await hiveService.addStanding(hiveStanding);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<StandingEntity>>> getAllStandings() async {
    try {
      // Get all standinges from Hive
      final standings = await hiveService.getAllStandings();
      print("from hive $standings");
      // Convert Hive Object to Entity
      final standingEntities = standingHiveModel.toEntityList(standings);
      return Right(standingEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> addStandingPlayer(
      StandingPlayerEntity standingPlayer) async {
    try {
      // Convert Entity to Hive Object
      final hiveStandingPlayer =
          standingPlayerHiveModel.toHiveModel(standingPlayer);
      // Add to Hive
      await hiveService.addStandingPlayer(hiveStandingPlayer);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<StandingPlayerEntity>>>
      getAllStandingPlayer() async {
    try {
      // Get all standinges from Hive
      final standingPlayer = await hiveService.getAllStandingPlayer();
      // Convert Hive Object to Entity
      final standingPlayerEntities =
          standingPlayerHiveModel.toEntityList(standingPlayer);
      return Right(standingPlayerEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
