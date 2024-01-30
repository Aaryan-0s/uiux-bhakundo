import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/player_entity.dart';
import '../dto/get_all_player_by_id_dto.dart';
import '../dto/get_all_player_dto.dart';
import '../model/player_api_model.dart';

final playerRemoteDataSourceProvider = Provider(
  (ref) => PlayerRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    playerApiModel: ref.read(playerApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class PlayerRemoteDataSource {
  final Dio dio;
  final PlayerApiModel playerApiModel;
  final UserSharedPrefs userSharedPrefs;

  PlayerRemoteDataSource({
    required this.dio,
    required this.playerApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<PlayerEntity>>> getAllPlayer(String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        "${ApiEndpoints.getAllPlayer}/$id/players",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllPlayerDTO getAllPlayerDTO =
            GetAllPlayerDTO.fromJson(response.data);

        return Right(playerApiModel.toEntityList(getAllPlayerDTO.data));
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

  Future<Either<Failure, List<PlayerEntity>>> getAllPlayerById(
      String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        "${ApiEndpoints.getAllPlayerById}/players/$id",
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllPlayerByIdDTO getAllPlayerByIdDTO =
            GetAllPlayerByIdDTO.fromJson(response.data);

        return Right(playerApiModel.toEntityList(getAllPlayerByIdDTO.data));
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
