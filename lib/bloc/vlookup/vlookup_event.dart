import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';

class AkunFetched extends Event {}

class AkunSearched extends Event {
  final String keyword;
  final List<Akun> data_akun;

  AkunSearched({this.keyword = "", this.data_akun = const <Akun>[]});
}

class AkunDetailed extends Event {
  final String kode;

  AkunDetailed({this.kode = ""});
}