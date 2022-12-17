import 'package:sistem_akuntansi/bloc/Event.dart';

class NeracaLajurFetched extends Event {
  String bulan;
  int tahun;

  NeracaLajurFetched({this.bulan = "", this.tahun = 0});
}