import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Akun extends Equatable {
  final String kode_akun;

  final String nama_akun;

  final String keterangan_akun;

  final int indentasi;

  const Akun({
    required this.kode_akun,
    required this.nama_akun,
    required this.keterangan_akun,
    required this.indentasi
  });

  factory Akun.fromJson(Map<String, dynamic> json) {
    return Akun(
        kode_akun: json['kode_akun'],
        nama_akun: json['nama_akun'],
        keterangan_akun: json['keterangan_akun'],
        indentasi: json['indentasi']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "kode_akun": this.kode_akun,
      "nama_akun": this.nama_akun,
      "keterangan_akun": this.keterangan_akun,
      "indentasi": this.indentasi,
    };
  }

  @override
  List<Object> get props =>
      [kode_akun, nama_akun, keterangan_akun, indentasi];

}
