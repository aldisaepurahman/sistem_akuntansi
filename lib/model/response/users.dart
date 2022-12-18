import 'package:equatable/equatable.dart';

class Users extends Equatable {
  String email;
  String password;

  Users({this.email = "", this.password = ""});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "password": this.password
    };
  }

  @override
  List<Object> get props => [email, password];


}