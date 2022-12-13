import 'package:equatable/equatable.dart';

class VJurnal extends Equatable {
  String id_transaksi;
  int id_jurnal;
  DateTime tgl_transaksi;
  String nama_transaksi;
  String no_bukti;
  List<Map<String, dynamic>> detail_transaksi;

  VJurnal(
      {this.id_transaksi = "",
      this.id_jurnal = 0,
      required this.tgl_transaksi,
      this.nama_transaksi = "",
      this.no_bukti = "",
      this.detail_transaksi = const <Map<String, dynamic>>[]});

  @override
  List<Object> get props => [
        id_transaksi,
        id_jurnal,
        tgl_transaksi,
        nama_transaksi,
        no_bukti,
        detail_transaksi
      ];
}
