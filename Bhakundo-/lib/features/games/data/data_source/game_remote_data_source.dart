import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nba_hub/config/constants/api_endpoint.dart';
import 'package:nba_hub/core/failure/failure.dart';
import 'package:nba_hub/core/network/remote/http_service.dart';
import 'package:nba_hub/core/shared_prefs/user_shared_prefs.dart';
import 'package:nba_hub/features/games/data/dto/get_all_game_dto.dart';
import 'package:nba_hub/features/games/data/dto/get_all_games_by_date_dto.dart';
import 'package:nba_hub/features/games/data/model/game_api_model.dart';
import 'package:nba_hub/features/games/data/model/game_hive_model.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';
import 'package:path_provider/path_provider.dart';

final gameRemoteDataSourceProvider = Provider(
  (ref) => GameRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    gameApiModel: ref.read(gameApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    gameHiveModel: ref.read(gameHiveModelProvider),
  ),
);

class GameRemoteDataSource {
  final Dio dio;
  final GameApiModel gameApiModel;
  final GameHiveModel gameHiveModel;

  final UserSharedPrefs userSharedPrefs;

  GameRemoteDataSource({
    required this.gameHiveModel,
    required this.dio,
    required this.gameApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<GameEntity>>> getAllGames() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      var response = await dio.get(
        ApiEndpoints.getgame,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetAllGameDTO gameAddDTO = GetAllGameDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<GameApiModel> games = data
            .map((item) => GameApiModel.fromJson(item as Map<String, dynamic>))
            .toList();
        final gameEntities = gameApiModel.toEntityList(games);

        final gameHiveModels = gameHiveModel.fromApiModelList(games);
        print(gameHiveModels);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);
        final gameBox = await Hive.openBox<GameHiveModel>('gameBox');

        gameBox.clear();
        gameBox.addAll(gameHiveModels);

        print("hive ko lagi: $gameEntities");

        return Right(gameApiModel.toEntityList(gameAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<GameEntity>>> getAllGameByDate(
      String season, String date) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.get(
        '${ApiEndpoints.getAllGameByDate}$season/$date',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetAllGameByDateDTO getAllGameDTO =
            GetAllGameByDateDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<GameApiModel> games = data
            .map((item) => GameApiModel.fromJson(item as Map<String, dynamic>))
            .toList();
        final gameEntities = gameApiModel.toEntityList(games);

        return Right(gameApiModel.toEntityList(getAllGameDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}
