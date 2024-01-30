import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:nba_hub/features/favourite/data/dto/add_favourite_dto.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/favourite_entity.dart';
import '../dto/get_favourite_dto.dart';
import '../model/favourite_api_model.dart';
import '../model/favourite_hive_model.dart';

final favouriteRemoteDataSourceProvider = Provider(
  (ref) => FavouriteRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    favouriteApiModel: ref.read(favouriteApiModelProvider),
    favouriteHiveModel: ref.read(favouriteHiveModelProvider),
  ),
);

class FavouriteRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final FavouriteApiModel favouriteApiModel;
  final FavouriteHiveModel favouriteHiveModel;

  FavouriteRemoteDataSource(
      {required this.userSharedPrefs,
      required this.dio,
      required this.favouriteApiModel,
      required this.favouriteHiveModel});

  Future<Either<Failure, List<FavouriteEntity>>> getFavourite() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.getFavourite,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetFavouriteDTO getFavouriteDTo =
            GetFavouriteDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<FavouriteApiModel> favourite = data
            .map((item) =>
                FavouriteApiModel.fromJson(item as Map<String, dynamic>))
            .toList();

        final favouriteHiveModels =
            favouriteHiveModel.fromApiModelList(favourite);
        print(favouriteHiveModels);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final favouriteBox =
            await Hive.openBox<FavouriteHiveModel>('favouriteBox');

        favouriteBox.clear();
        favouriteBox.addAll(favouriteHiveModels);
        print(data);

        return Right(favouriteApiModel.toEntityList(getFavouriteDTo.data));
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

  Future<Either<Failure, List<FavouriteEntity>>> addFavourite(
      FavouriteEntity favourite) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.post(
        ApiEndpoints.addFavourite,
        data: {
          "teamId": favourite.teamId,
          "teamName": favourite.teamName,
          "logoUrl": favourite.logoUrl,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        AddFavouriteDTO addFavouriteDTo =
            AddFavouriteDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        print(data);

        return Right(favouriteApiModel.toEntityList(addFavouriteDTo.data));
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

  Future<Either<Failure, bool>> removeFavourite(String id) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        '${ApiEndpoints.removeFavourite}/$id',
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
