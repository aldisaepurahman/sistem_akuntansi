import 'package:sistem_akuntansi/bloc/Event.dart';

class JurnalFetched extends Event {
  final int bulan;
  final int tahun;
  final int id_jurnal;

  JurnalFetched({required this.bulan, required this.tahun, this.id_jurnal = 0});
}