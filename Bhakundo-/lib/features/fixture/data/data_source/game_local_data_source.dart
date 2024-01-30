// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../core/failure/failure.dart';
// import '../../../../core/network/local/hive_service.dart';
// import '../../domain/entity/game_entity.dart';
// import '../model/game_hive_model.dart';

// // Dependency Injection using Riverpod
// final gameLocalDataSourceProvider = Provider<GameLocalDataSource>((ref) {
//   return GameLocalDataSource(
//       hiveService: ref.read(hiveServiceProvider),
//       gameHiveModel: ref.read(gameHiveModelProvider));
// });

// class GameLocalDataSource {
//   final HiveService hiveService;
//   final GameHiveModel gameHiveModel;

//   GameLocalDataSource({
//     required this.hiveService,
//     required this.gameHiveModel,
//   });

//   // Add Game
//   Future<Either<Failure, bool>> addGame(GameEntity game) async {
//     try {
//       // Convert Entity to Hive Object
//       final hiveGame = gameHiveModel.toHiveModel(game);
//       // Add to Hive
//       await hiveService.addGame(hiveGame);
//       return const Right(true);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }

//   Future<Either<Failure, List<GameEntity>>> getAllGames() async {
//     try {
//       // Get all gamees from Hive
//       final games = await hiveService.getAllGames();
//       // Convert Hive Object to Entity
//       final gameEntities = gameHiveModel.toEntityList(games);
//       return Right(gameEntities);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
// }
