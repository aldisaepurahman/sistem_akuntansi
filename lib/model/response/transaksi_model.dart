import 'package:equatable/equatable.dart';

class TransaksiModel extends Equatable {
  final String id_transaksi;
  final DateTime tgl_transaksi;
  final String nama_transaksi;
  final String no_bukti;
  final int id_jurnal;

  const TransaksiModel(
      {this.id_transaksi = "",
      required this.tgl_transaksi,
      required this.nama_transaksi,
      required this.no_bukti,
      required this.id_jurnal});

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
        id_transaksi: json['id_transaksi'],
        tgl_transaksi: json['tgl_transaksi'],
        nama_transaksi: json['nama_transaksi'],
        no_bukti: json['no_bukti'],
        id_jurnal: json['id_jurnal']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaksi': this.id_transaksi,
      'tgl_transaksi': this.tgl_transaksi.toIso8601String(),
      'nama_transaksi': this.nama_transaksi,
      'no_bukti': this.no_bukti,
      'jurnal_id_jurnal': this.id_jurnal
    };
  }

  @override
  List<Object> get props => [
        id_transaksi,
        tgl_transaksi,
        nama_transaksi,
        no_bukti,
        id_jurnal
      ];
}
