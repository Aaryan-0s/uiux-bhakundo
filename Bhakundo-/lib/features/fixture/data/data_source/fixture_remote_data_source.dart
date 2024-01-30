import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/fixture/data/model/fixture_info_api_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/fixture_entity.dart';
import '../../domain/entity/fixture_info_entity.dart';
import '../dto/get_fixture_by_id_dto.dart';
import '../dto/get_fixture_info_dto.dart';
import '../model/fixture_api_model.dart';

final fixtureRemoteDataSourceProvider = Provider(
  (ref) => FixtureRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    fixtureApiModel: ref.read(fixtureApiModelProvider),
    fixtureInfoApiModel: ref.read(fixtureInfoApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    // fixtureHiveModel: ref.read(fixtureHiveModelProvider),
  ),
);

class FixtureRemoteDataSource {
  final Dio dio;
  final FixtureApiModel fixtureApiModel;
  final FixtureInfoApiModel fixtureInfoApiModel;
  // final FixtureHiveModel fixtureHiveModel;

  final UserSharedPrefs userSharedPrefs;

  FixtureRemoteDataSource({
    // required this.fixtureHiveModel,
    required this.dio,
    required this.fixtureApiModel,
    required this.fixtureInfoApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<FixtureEntity>>> getFixtureById(String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.get(
        ApiEndpoints.getFixtureById + id,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetFixtureByIdDTO getAllFixtureDTO =
            GetFixtureByIdDTO.fromJson(response.data);
        print(getAllFixtureDTO.data);
        return Right(fixtureApiModel.toEntityList(getAllFixtureDTO.data));
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

  Future<Either<Failure, List<FixtureInfoEntity>>> getFixtureInfo(
      String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.get(
        ApiEndpoints.getFixtureInfo + id,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetFixtureInfoDTO getAllFixtureInfo =
            GetFixtureInfoDTO.fromJson(response.data);
        print(getAllFixtureInfo.data);
        return Right(fixtureInfoApiModel.toEntityList(getAllFixtureInfo.data));
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
