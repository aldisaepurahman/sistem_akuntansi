import 'package:equatable/equatable.dart';

class TransaksiDK extends Equatable {
  int id_transaksi_dk;
  String id_transaksi;
  String jenis_transaksi;
  int nominal_transaksi;
  String kode_akun;

  TransaksiDK(
      {this.id_transaksi_dk = 0,
      this.id_transaksi = "",
      this.jenis_transaksi = "",
      this.nominal_transaksi = 0,
      this.kode_akun = ""});

  factory TransaksiDK.fromJson(Map<String, dynamic> json) {
    return TransaksiDK(
        id_transaksi_dk: json['id_transaksi_dk'],
        id_transaksi: json['id_transaksi'],
        jenis_transaksi: json['jenis_transaksi'],
        nominal_transaksi: json['nominal_transaksi'],
      kode_akun: json['kode_akun']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jenis_transaksi': this.jenis_transaksi,
      'nominal_transaksi': this.nominal_transaksi,
      'transaksi_utama_id_transaksi': this.id_transaksi,
      'coa_kode_akun': this.kode_akun
    };
  }

  @override
  List<Object> get props =>
      [id_transaksi_dk, id_transaksi, jenis_transaksi, nominal_transaksi, kode_akun];
}
