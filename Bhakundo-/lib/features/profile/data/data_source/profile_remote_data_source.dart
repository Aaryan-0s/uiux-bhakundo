import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:nba_hub/features/profile/data/dto/get_profile_dto.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../model/profile_api_model.dart';
import '../model/profile_hive_model.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    profileApiModel: ref.read(profileApiModelProvider),
    profileHiveModel: ref.read(profileHiveModelProvider),
  ),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final ProfileApiModel profileApiModel;
  final ProfileHiveModel profileHiveModel;

  ProfileRemoteDataSource(
      {required this.userSharedPrefs,
      required this.dio,
      required this.profileApiModel,
      required this.profileHiveModel});

  Future<Either<Failure, List<ProfileEntity>>> getProfile() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.get(
        ApiEndpoints.getUser,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        GetProfileDTO getProfileDTo = GetProfileDTO.fromJson(response.data);
        var data = response.data['data'] as List<dynamic>;
        List<ProfileApiModel> profile = data
            .map((item) =>
                ProfileApiModel.fromJson(item as Map<String, dynamic>))
            .toList();
        final profileEntities = profileApiModel.toEntityList(profile);
        final profileHiveModels = profileHiveModel.fromApiModelList(profile);
        print(profileHiveModels);

        var directory = await getApplicationDocumentsDirectory();
        Hive.init(directory.path);

        final profileBox = await Hive.openBox<ProfileHiveModel>('profileBox');

        profileBox.clear();
        profileBox.addAll(profileHiveModels);

        return Right(profileApiModel.toEntityList(getProfileDTo.data));
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

  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.put(
        ApiEndpoints.updateProfile,
        data: {
          'fname': profile.fname,
          'lname': profile.lname,
          'email': profile.email,
          'username': profile.username,
          "image": profile.image,
        },
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

  Future<Either<Failure, bool>> deleteProfile() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteProfile,
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

  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
        options: Options(),
      );

      return Right(response.data["data"]);
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

  // Upload image using multipart

