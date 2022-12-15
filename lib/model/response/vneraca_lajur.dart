import 'package:equatable/equatable.dart';

class VNeracaLajur extends Equatable {
  String kode_akun;
  String nama_akun;
  String keterangan;
  int saldo;
  String bulan;
  int tahun;
  int saldo_jurnal_umum;
  int saldo_jurnal_penyesuaian;
  int neraca_saldo;
  int neraca_saldo_disesuaikan;

  VNeracaLajur({
    this.kode_akun = "",
    this.nama_akun = "",
    this.keterangan = "",
    this.saldo = 0,
    this.bulan = "",
    this.tahun = 0,
    this.saldo_jurnal_umum = 0,
    this.saldo_jurnal_penyesuaian = 0,
    this.neraca_saldo = 0,
    this.neraca_saldo_disesuaikan = 0
  });

  factory VNeracaLajur.fromJson(Map<String, dynamic> json) {
    return VNeracaLajur(
      kode_akun: json['kode_akun'],
      nama_akun: json['nama_akun'],
      keterangan: json['keterangan'],
      saldo: json['saldo'],
      bulan: json['bulan'],
      tahun: json['tahun'],
      saldo_jurnal_umum: json['saldo_jurnal_umum'],
      saldo_jurnal_penyesuaian: json['saldo_jurnal_penyesuaian'],
      neraca_saldo: json['neraca_saldo'],
      neraca_saldo_disesuaikan: json['neraca_saldo_disesuaikan']
    );
  }

  @override
  List<Object> get props => [
    kode_akun,
    nama_akun,
    keterangan,
    saldo,
    bulan,
    tahun,
    saldo_jurnal_umum,
    saldo_jurnal_penyesuaian,
    neraca_saldo,
    neraca_saldo_disesuaikan
  ];


}