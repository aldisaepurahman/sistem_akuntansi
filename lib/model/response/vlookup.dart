import 'package:equatable/equatable.dart';

class VLookup extends Equatable {
  final String nama_akun;
  final String kode;
  final int id_saldo;
  final int saldo;
  final int bulan;
  final int tahun;
  final String keterangan;
  final int indentasi;

  const VLookup({
    required this.nama_akun,
    required this.kode,
    required this.id_saldo,
    required this.saldo,
    required this.bulan,
    required this.tahun,
    required this.keterangan,
    required this.indentasi
  });

  factory VLookup.fromJson(Map<String, dynamic> json) {
    return VLookup(
        nama_akun: json['nama_akun'],
        kode: json['kode'],
        id_saldo: json['id_saldo'],
        saldo: json['saldo'],
        bulan: json['bulan'],
        tahun: json['tahun'],
        keterangan: json['keterangan'],
        indentasi: json['indentasi']);
  }

  @override
  List<Object> get props => [nama_akun, kode, saldo, bulan, tahun, keterangan, indentasi];

}