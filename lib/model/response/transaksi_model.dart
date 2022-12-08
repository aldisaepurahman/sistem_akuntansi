import 'package:equatable/equatable.dart';

class Transaksi extends Equatable {
  final int id_transaksi;
  final String tgl_transaksi;
  final String nama_transaksi;
  final String no_bukti;
  final int id_jurnal;
  final String kode_akun;

  const Transaksi(
      {this.id_transaksi = 0,
      required this.tgl_transaksi,
      required this.nama_transaksi,
      required this.no_bukti,
      required this.id_jurnal,
      required this.kode_akun});

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
        id_transaksi: json['id_transaksi'],
        tgl_transaksi: json['tgl_transaksi'],
        nama_transaksi: json['nama_transaksi'],
        no_bukti: json['no_bukti'],
        id_jurnal: json['id_jurnal'],
        kode_akun: json['kode_akun']);
  }

  Map<String, dynamic> toJson() {
    return {
      'tgl_transaksi': this.tgl_transaksi,
      'nama_transaksi': this.nama_transaksi,
      'no_bukti': this.no_bukti,
      'id_jurnal': this.id_jurnal,
      'kode_akun': this.kode_akun
    };
  }

  @override
  List<Object> get props => [
        id_transaksi,
        tgl_transaksi,
        nama_transaksi,
        no_bukti,
        id_jurnal,
        kode_akun
      ];
}
