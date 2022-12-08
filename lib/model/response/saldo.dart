import 'package:equatable/equatable.dart';

class Saldo extends Equatable {
  final int id_saldo;
  final int saldo;
  final int bulan;
  final int tahun;
  final String kode_akun;

  const Saldo({
    required this.id_saldo,
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
      'id_saldo': this.id_saldo,
      'saldo': this.saldo,
      'bulan': this.bulan,
      'tahun': this.tahun,
      'kode_akun': this.kode_akun,
    };
  }

  @override
  List<Object> get props => [id_saldo, saldo, bulan, tahun, kode_akun];
}