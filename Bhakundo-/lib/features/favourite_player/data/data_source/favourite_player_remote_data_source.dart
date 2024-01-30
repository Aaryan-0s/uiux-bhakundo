import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/favourite_entity.dart';
import '../dto/add_favourite_player_dto.dart';
import '../dto/get_favourite_player_dto.dart';
import '../model/favourite_player_api_model.dart';
import '../model/favourite_player_hive_model.dart';

final favouritePlayerRemoteDataSourceProvider = Provider(
  (ref) => FavouritePlayerRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
      favouritePlayerApiModel: ref.read(favouritePlayerApiModelProvider),
      favouritePlayerHiveModel: ref.read(favouritePlayerHiveModelProvider)),
);

class FavouritePlayerRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final FavouritePlayerApiModel favouritePlayerApiModel;
  final FavouritePlayerHiveModel favouritePlayerHiveModel;

  FavouritePlayerRemoteDataSource(
      {required this.userSharedPrefs,
      required this.dio,
      required this.favouritePlayerApiModel,
      required this.favouritePlayerHiveModel});

  Future<Either<Failure, List<FavouritePlayerEntity>>>
      getFavouritePlayer() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.getFavouritePlayer,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetFavouritePlayerDTO getFavouritePlayerDTo =
            GetFavouritePlayerDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<FavouritePlayerApiModel> favouritePlayer = data
            .map((item) =>
                FavouritePlayerApiModel.fromJson(item as Map<String, dynamic>))
            .toList();
        final favouritePlayerEntities =
            favouritePlayerApiModel.toEntityList(favouritePlayer);
        final favouritePlayerHiveModels =
            favouritePlayerHiveModel.fromApiModelList(favouritePlayer);
        print(favouritePlayerHiveModels);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final favouritePlayerBox =
            await Hive.openBox<FavouritePlayerHiveModel>('favouritePlayerBox');

        favouritePlayerBox.clear();
        favouritePlayerBox.addAll(favouritePlayerHiveModels);
        print(data);

        return Right(
            favouritePlayerApiModel.toEntityList(getFavouritePlayerDTo.data));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<FavouritePlayerEntity>>> addFavouritePlayer(
      FavouritePlayerEntity favouritePlayer) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        ApiEndpoints.addFavouritePlayer,
        data: {
          "playerId": favouritePlayer.playerId,
          "playerName": favouritePlayer.playerName,
          "photoUrl": favouritePlayer.photoUrl,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        AddFavouritePlayerDTO addFavouritePlayerDTo =
            AddFavouritePlayerDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        print(data);

        return Right(
            favouritePlayerApiModel.toEntityList(addFavouritePlayerDTo.data));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> removeFavouritePlayer(String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        '${ApiEndpoints.removeFavouritePlayer}/$id',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
