// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../core/failure/failure.dart';
// import '../../domain/entity/fixture_entity.dart';
// import '../../domain/repository/fixture_repository.dart';
// import '../data_source/game_local_data_source.dart';

// final gameLocalRepoProvider = Provider<IGameRepository>((ref) {
//   return GameLocalRepositoryImpl(
//     gameLocalDataSource: ref.read(gameLocalDataSourceProvider),
//   );
// });

// class GameLocalRepositoryImpl implements IGameRepository {
//   final GameLocalDataSource gameLocalDataSource;

//   GameLocalRepositoryImpl({
//     required this.gameLocalDataSource,
//   });

//   @override
//   Future<Either<Failure, List<GameEntity>>> getAllGames() {
//     return gameLocalDataSource.getAllGames();
//   }

//   @override
//   Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
//       String season, String date) {
//     throw UnimplementedError();
//   }
// }
