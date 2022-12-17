import 'package:sistem_akuntansi/bloc/Event.dart';

class LabaRugiFetched extends Event {
  String bulan;
  int tahun;

  LabaRugiFetched({this.bulan = "", this.tahun = 0});
}