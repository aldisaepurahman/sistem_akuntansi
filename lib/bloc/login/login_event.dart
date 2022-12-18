import 'package:sistem_akuntansi/bloc/Event.dart';

class LoginFetched extends Event {
  String email;
  String password;

  LoginFetched({this.email = "", this.password = ""});
}