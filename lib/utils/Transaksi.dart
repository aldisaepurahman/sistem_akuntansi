import 'package:sistem_akuntansi/utils/V_detail_transaksi.dart';

class Transaksi {
  String tanggal;
  List<V_detail_transaksi> transaksi_debit;
  List<V_detail_transaksi> transaksi_kredit;

  Transaksi({
    required this.tanggal,
    required this.transaksi_debit,
    required this.transaksi_kredit,
  });
}

List<Transaksi> contents_transaksi = [
  Transaksi(
    tanggal: "29/03",
    transaksi_debit: contents_debit,
    transaksi_kredit: contents_kredit,
  ),
  Transaksi(
    tanggal: "29/03",
    transaksi_debit: contents_debit,
    transaksi_kredit: contents_kredit,
  ),
  Transaksi(
    tanggal: "29/03",
    transaksi_debit: contents_debit,
    transaksi_kredit: contents_kredit,
  ),
];