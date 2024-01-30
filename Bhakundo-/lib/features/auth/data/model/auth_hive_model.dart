// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive/hive.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../config/constants/hive_table_constant.dart';
// import '../../domain/entity/auth_entity.dart';

// part 'auth_hive_model.g.dart';

// final authHiveModelProvider = Provider(
//   (ref) => AuthHiveModel.empty(),
// );

// @HiveType(typeId: HiveTableConstant.authTableId)
// class AuthHiveModel {
//   @HiveField(0)
//   final String userId;

//   @HiveField(1)
//   final String fname;

//   @HiveField(2)
//   final String lname;

//   @HiveField(4)
//   final String username;

//   @HiveField(5)
//   final String password;

//   @HiveField(6)
//   final String email;

//   // Constructor
//   AuthHiveModel({
//     required this.userId,
//     required this.fname,
//     required this.lname,
//     required this.username,
//     required this.password,
//     required this.email,
//   });

//   // empty constructor
//   AuthHiveModel.empty()
//       : userId = '',
//         fname = '',
//         lname = '',
//         username = '',
//         password = '',
//         email = '';

//   // Convert Hive Object to Entity
//   AuthEntity toEntity() => AuthEntity(
//         fname: fname,
//         lname: lname,
//         username: username,
//         password: password,
//         email: email,
//       );

//   // Convert Entity to Hive Object
//   AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
//         userId: const Uuid().v4(),
//         fname: entity.fname,
//         lname: entity.lname,
//         username: entity.username,
//         password: entity.password,
//         email: entity.email,
//       );

//   // Convert Entity List to Hive List
//   List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
//       entities.map((entity) => toHiveModel(entity)).toList();

//   @override
//   String toString() {
//     return 'AuthHiveModel(fname: $fname, lname: $lname, username: $username, password: $password, email: $email)';
//   }
// }
