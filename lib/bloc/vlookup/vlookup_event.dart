import 'package:sistem_akuntansi/bloc/Event.dart';

class AkunFetched extends Event {
  final String keyword;

  AkunFetched({this.keyword = ""});
}