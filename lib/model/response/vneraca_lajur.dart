import 'package:equatable/equatable.dart';

class VNeracaLajur extends Equatable {
  String kode_akun;
  String nama_akun;
  String keterangan;
  int? saldo;
  String? bulan;
  int? tahun;
  int saldo_jurnal_umum;
  int? saldo_jurnal_penyesuaian;
  int? neraca_saldo;
  int? neraca_saldo_disesuaikan;

  VNeracaLajur({
    this.kode_akun = "",
    this.nama_akun = "",
    this.keterangan = "",
    this.saldo,
    this.bulan,
    this.tahun,
    this.saldo_jurnal_umum = 0,
    this.saldo_jurnal_penyesuaian,
    this.neraca_saldo,
    this.neraca_saldo_disesuaikan
  });

  factory VNeracaLajur.fromJson(Map<String, dynamic> json) {
    return VNeracaLajur(
      kode_akun: json['kode_akun'],
      nama_akun: json['nama_akun'],
      keterangan: json['keterangan_akun'],
      saldo: json['saldo'] ?? 0,
      bulan: json['bulan'] ?? "",
      tahun: json['tahun'] ?? 0,
      saldo_jurnal_umum: json['saldo_jurnal'],
      saldo_jurnal_penyesuaian: json['saldo_jurnal_penyesuaian'] ?? 0,
      neraca_saldo: json['neraca_saldo'] ?? 0,
      neraca_saldo_disesuaikan: json['neraca_saldo_disesuaikan'] ?? 0
    );
  }

  @override
  List<Object> get props => [
    kode_akun,
    nama_akun,
    keterangan,
    saldo ?? 0,
    bulan ?? "",
    tahun ?? 0,
    saldo_jurnal_umum,
    saldo_jurnal_penyesuaian ?? 0,
    neraca_saldo ?? 0,
    neraca_saldo_disesuaikan ?? 0
  ];


}