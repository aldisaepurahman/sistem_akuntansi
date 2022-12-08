import 'package:equatable/equatable.dart';

class VJurnal extends Equatable {
  final int id_transaksi;
  final int id_jurnal;
  final int id_jenis_jurnal;
  final String tgl_transaksi;
  final String nama_transaksi;
  final String no_bukti;
  final List<Map<String, dynamic>> detail_transaksi;

  const VJurnal(
      {required this.id_transaksi,
      required this.id_jurnal,
      required this.id_jenis_jurnal,
      required this.tgl_transaksi,
      required this.nama_transaksi,
      required this.no_bukti,
      this.detail_transaksi = const <Map<String, dynamic>>[]});

  @override
  List<Object> get props => [
        id_transaksi,
        id_jurnal,
        id_jenis_jurnal,
        tgl_transaksi,
        nama_transaksi,
        no_bukti,
        detail_transaksi
      ];
}
