import 'package:equatable/equatable.dart';

class Saldo extends Equatable {
  int id_saldo;
  int saldo;
  String bulan;
  int tahun;
  String kode_akun;

  Saldo({
    this.id_saldo = 0,
    required this.saldo,
    required this.bulan,
    required this.tahun,
    required this.kode_akun
  });

  factory Saldo.fromJson(Map<String, dynamic> json) {
    return Saldo(
        id_saldo: json['id_saldo'],
        saldo: json['saldo'],
        bulan: json['bulan'],
        tahun: json['tahun'],
        kode_akun: json['kode_akun']);
  }

  Map<String, dynamic> toJson() {
    return {
      'bulan': this.bulan,
      'tahun': this.tahun,
      'saldo': this.saldo,
      'kode_akun': this.kode_akun,
    };
  }

  @override
  List<Object> get props => [id_saldo, saldo, bulan, tahun, kode_akun];
}