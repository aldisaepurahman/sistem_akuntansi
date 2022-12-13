import 'package:equatable/equatable.dart';

class AmortisasiAkun extends Equatable {
  String id_amortisasi_akun;
  String kode_akun;
  String nama_akun;
  String amortisasi_jenis;

  AmortisasiAkun({this.id_amortisasi_akun = "", this.kode_akun = "", this.nama_akun = "", this.amortisasi_jenis = ""});

  factory AmortisasiAkun.fromJson(Map<String, dynamic> json) {
    return AmortisasiAkun(
      id_amortisasi_akun: json['id_amortisasi_akun'],
      kode_akun: json['coa_kode_akun'],
      nama_akun: json['nama_akun_amortisasi'],
      amortisasi_jenis: json['amortisasi_jenis']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_akun': this.id_amortisasi_akun,
      'coa_kode_akun': this.kode_akun,
      'nama_akun_amortisasi': this.nama_akun,
      'amortisasi_jenis': this.amortisasi_jenis,
    };
  }

  @override
  List<Object> get props => [id_amortisasi_akun, kode_akun, amortisasi_jenis];
}