import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/transaksi_debit_kredit.dart';
import 'package:sistem_akuntansi/model/response/transaksi_model.dart';

class JurnalFetched extends Event {
  final int bulan;
  final int tahun;
  final int id_jurnal;

  JurnalFetched({this.bulan = 0, this.tahun = 0, this.id_jurnal = 0});
}

class JurnalInserted extends Event {
  final TransaksiModel transaksiModel;
  final List<TransaksiDK> transaksi_dk;

  JurnalInserted({required this.transaksiModel, required this.transaksi_dk});
}

class JurnalDeleted extends Event {
  final String id_transaksi;

  JurnalDeleted({this.id_transaksi = ""});
}