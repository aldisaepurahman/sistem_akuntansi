import 'package:equatable/equatable.dart';

class VLookup extends Equatable {
  final String nama_akun;
  final String kode;
  final int id_saldo;
  final int saldo;
  final String bulan;
  final int tahun;
  final String keterangan;
  final int indentasi;

  const VLookup({
    this.nama_akun = "",
    this.kode = "",
    this.id_saldo = 0,
    this.saldo = 0,
    this.bulan = "",
    this.tahun = 0,
    this.keterangan = "",
    this.indentasi = 0
  });

  factory VLookup.fromJson(Map<String, dynamic> json) {
    return VLookup(
        nama_akun: json['nama_akun'],
        keterangan: json['keterangan_akun'],
        kode: json['kode_akun'],
        id_saldo: json['id_saldo'],
        bulan: json['bulan'],
        tahun: json['tahun'],
        saldo: json['saldo'],
        indentasi: json['indentasi']);
  }

  @override
  List<Object> get props => [nama_akun, kode, saldo, bulan, tahun,
    keterangan,
    indentasi];

}