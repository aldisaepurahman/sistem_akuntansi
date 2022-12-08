import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Akun extends Equatable {
  final String kode_akun;

  final String nama_akun;

  final String keterangan_akun;

  final int id_saldo;

  final int kode_reference;

  const Akun({
    required this.kode_akun,
    required this.nama_akun,
    required this.keterangan_akun,
    required this.id_saldo,
    required this.kode_reference
  });

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
        kode_akun: json['kode_akun'],
        nama_akun: json['nama_akun'],
        keterangan_akun: json['keterangan_akun'],
        id_saldo: json['id_saldo'],
        kode_reference: json['kode_reference']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "kode_akun": this.kode_akun,
      "nama_akun": this.nama_akun,
      "keterangan_akun": this.keterangan_akun,
      "id_saldo": this.id_saldo,
      "kode_reference": this.kode_reference,
    };
  }

  @override
  List<Object> get props =>
      [kode_akun, nama_akun, keterangan_akun, id_saldo, kode_reference];

}
