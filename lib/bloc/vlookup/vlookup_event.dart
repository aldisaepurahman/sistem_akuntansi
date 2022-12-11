import 'package:sistem_akuntansi/bloc/Event.dart';

class AkunFetched extends Event {}

class AkunSearched extends Event {
  final String keyword;

  AkunSearched({this.keyword = ""});
}

class AkunDetailed extends Event {
  final String kode;

  AkunDetailed({this.kode = ""});
}