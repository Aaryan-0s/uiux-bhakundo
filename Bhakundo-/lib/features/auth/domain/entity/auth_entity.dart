import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String fname;
  final String lname;
  final String? image;
  final String email;
  final String username;
  final String password;

  const AuthEntity({
    required this.fname,
    required this.lname,
    this.image,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [fname, lname, image, email, username, password];
}
