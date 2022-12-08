import 'package:sistem_akuntansi/bloc/Event.dart';

class BulanFetched extends Event {
  final int bulan;
  final int tahun;

  BulanFetched({this.bulan = 0, this.tahun = 0});
}