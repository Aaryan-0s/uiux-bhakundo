import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? userId;
  final String fname;
  final String lname;
  final dynamic image;
  final String email;
  final String username;

  const ProfileEntity({
    this.userId,
    required this.fname,
    required this.lname,
    required this.image,
    required this.email,
    required this.username,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        userId: json["_id"],
        username: json["username"],
        fname: json["fname"],
        lname: json["lname"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "fname": fname,
        "lname": lname,
        "email": email,
        "image": image,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [userId, fname, lname, image, email, username];
}
