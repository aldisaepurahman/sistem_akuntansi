import 'package:equatable/equatable.dart';

class TransaksiDK extends Equatable {
  final int id_transaksi_dk;
  final int id_transaksi;
  final String jenis_transaksi;
  final int nominal_transaksi;

  const TransaksiDK(
      {this.id_transaksi_dk = 0,
      required this.id_transaksi,
      required this.jenis_transaksi,
      required this.nominal_transaksi});

  factory TransaksiDK.fromJson(Map<String, dynamic> json) {
    return TransaksiDK(
        id_transaksi_dk: json['id_transaksi_dk'],
        id_transaksi: json['id_transaksi'],
        jenis_transaksi: json['jenis_transaksi'],
        nominal_transaksi: json['nominal_transaksi']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_transaksi': this.id_transaksi,
      'jenis_transaksi': this.jenis_transaksi,
      'nominal_transaksi': this.nominal_transaksi
    };
  }

  @override
  List<Object> get props =>
      [id_transaksi_dk, id_transaksi, jenis_transaksi, nominal_transaksi];
}
