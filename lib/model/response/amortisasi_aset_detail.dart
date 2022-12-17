import 'package:equatable/equatable.dart';

class AmortisasiAsetDetail extends Equatable {
  int id_detail;
  String id_amortisasi_aset;
  String bulan;
  int tahun;
  int nominal_penyusutan;

  AmortisasiAsetDetail(
      {this.id_detail = 0,
      this.id_amortisasi_aset = "",
      this.bulan = "",
      this.tahun = 0,
      this.nominal_penyusutan = 0});

  factory AmortisasiAsetDetail.fromJson(Map<String, dynamic> json) {
    return AmortisasiAsetDetail(
      id_detail: json['id_aset_detail'],
      id_amortisasi_aset: json['id_amortisasi_aset'],
      bulan: json['bulan'],
      tahun: json['tahun'],
      nominal_penyusutan: json['nominal_penyusutan'].toInt()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_aset': this.id_amortisasi_aset,
      'bulan': this.bulan,
      'tahun': this.tahun,
      'nominal_penyusutan': this.nominal_penyusutan
    };
  }

  @override
  List<Object> get props => [id_detail, id_amortisasi_aset, bulan, tahun, nominal_penyusutan];
}
