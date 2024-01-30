import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    fname: '',
    studentId: '',
    lname: '',
    username: '',
    password: '',
    image: '',
    email: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String studentId;
  @JsonKey(name: 'fname')
  final String fname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'lname')
  final String lname;
  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'image')
  final String? image;

  AuthApiModel({
    required this.studentId,
    required this.fname,
    required this.lname,
    this.image,
    required this.username,
    required this.password,
    required this.email,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  AuthEntity toEntity() => AuthEntity(
        fname: fname,
        lname: lname,
        image: image,
        email: email,
        username: username,
        password: password,
      );

  // Convert AuthApiModel list to AuthEntity list
  List<AuthEntity> listFromJson(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel( id: $studentId, fname: $fname, lname: $lname, image: $image,username: $username, password: $password)';
  }
}
