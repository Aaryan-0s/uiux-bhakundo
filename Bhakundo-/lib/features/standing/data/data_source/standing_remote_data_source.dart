import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/standing_entity.dart';
import '../../domain/entity/standing_player_entity.dart';
import '../dto/get_all_standing_dto.dart';
import '../dto/get_all_standing_player_dto.dart';
import '../model/standing_api_model.dart';
import '../model/standing_hive_model.dart';
import '../model/standing_player_api_model.dart';
import '../model/standing_player_hive_model.dart';

final standingRemoteDataSourceProvider = Provider(
  (ref) => StandingRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    standingApiModel: ref.read(standingApiModelProvider),
    standingPlayerApiModel: ref.read(standingPlayerApiModelProvider),
    standingHiveModel: ref.read(standingHiveModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    standingPlayerHiveModel: ref.read(standingPlayerHiveModelProvider),
  ),
);

class StandingRemoteDataSource {
  final Dio dio;
  final StandingApiModel standingApiModel;
  final UserSharedPrefs userSharedPrefs;
  final StandingHiveModel standingHiveModel;
  final StandingPlayerHiveModel standingPlayerHiveModel;

  final StandingPlayerApiModel standingPlayerApiModel;

  StandingRemoteDataSource({
    required this.dio,
    required this.standingApiModel,
    required this.standingPlayerHiveModel,
    required this.userSharedPrefs,
    required this.standingHiveModel,
    required this.standingPlayerApiModel,
  });

  Future<Either<Failure, List<StandingEntity>>> getAllStanding() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        ApiEndpoints.getAllStanding,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllStandingDTO standingDTO =
            GetAllStandingDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<StandingApiModel> standingTeam = data
            .map((item) =>
                StandingApiModel.fromJson(item as Map<String, dynamic>))
            .toList();

        final standingHiveModels =
            standingHiveModel.fromApiModelList(standingTeam);
        print(standingHiveModels);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final standingBox =
            await Hive.openBox<StandingHiveModel>('standingTeamBox');

        standingBox.clear();
        standingBox.addAll(standingHiveModels);
        // print("hive ko lagi: $standingTeamEntities");

        return Right(standingApiModel.toEntityList(standingDTO.data));
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

  Future<Either<Failure, List<StandingEntity>>> getStandingByTeamId(
      String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        '${ApiEndpoints.getStandingByTeamId}$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetAllStandingDTO standingDTO =
            GetAllStandingDTO.fromJson(response.data);
        return Right(standingApiModel.toEntityList(standingDTO.data));
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

  Future<Either<Failure, List<StandingPlayerEntity>>>
      getAllStandingPlayer() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        ApiEndpoints.getAllStandingPlayer,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllStandingPlayerDTO standingPlayerDTO =
            GetAllStandingPlayerDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<StandingPlayerApiModel> standingPlayer = data
            .map((item) =>
                StandingPlayerApiModel.fromJson(item as Map<String, dynamic>))
            .toList();

        final standingPlayerEntities =
            standingPlayerApiModel.toEntityList(standingPlayer);

        final standingPlayerHiveModels =
            standingPlayerHiveModel.fromApiModelList(standingPlayer);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final standingPlayerBox =
            await Hive.openBox<StandingPlayerHiveModel>('standingPlayerBox');

        standingPlayerBox.clear();
        standingPlayerBox.addAll(standingPlayerHiveModels);
        print("hive ko lagi: $standingPlayerEntities");
        return Right(
            standingPlayerApiModel.toEntityList(standingPlayerDTO.data));
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
