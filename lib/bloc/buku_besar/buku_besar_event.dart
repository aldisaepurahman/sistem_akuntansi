import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/transaksi_debit_kredit.dart';
import 'package:sistem_akuntansi/model/response/transaksi_model.dart';

class BukuBesarFetched extends Event {
  final int bulan;
  final int tahun;
  final String kode_akun;

  BukuBesarFetched({this.bulan = 0, this.tahun = 0, this.kode_akun = ""});
}