import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/team_entity.dart';
import '../dto/get_all_team_dto.dart';
import '../model/team_api_model.dart';

final teamRemoteDataSourceProvider = Provider(
  (ref) => TeamRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    teamApiModel: ref.read(teamApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class TeamRemoteDataSource {
  final Dio dio;
  final TeamApiModel teamApiModel;
  final UserSharedPrefs userSharedPrefs;

  TeamRemoteDataSource({
    required this.dio,
    required this.teamApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<TeamEntity>>> getAllTeam(String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        '${ApiEndpoints.getAllTeam}$id/stats',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetAllTeamDTO getAllTeamDTO = GetAllTeamDTO.fromJson(response.data);
        // var data = response.data['data'] as Map<String, dynamic>;
        // List<TeamApiModel> teams = data
        //     .map((item) => TeamApiModel.fromJson(item as Map<String, dynamic>))
        //     .toList();
        // final teamEntities = teamApiModel.toEntityList(teams);
        // print(teamEntities);
        // print(data);

        return Right(teamApiModel.toEntityList(getAllTeamDTO.data));
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
