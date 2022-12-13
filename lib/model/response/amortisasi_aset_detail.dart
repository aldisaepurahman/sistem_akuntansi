import 'package:equatable/equatable.dart';

class AmortisasiAsetDetail extends Equatable {
  int id_detail;
  String id_amortisasi_aset;
  String bulan;
  int tahun;
  double kali;

  AmortisasiAsetDetail(
      {this.id_detail = 0,
      this.id_amortisasi_aset = "",
      this.bulan = "",
      this.tahun = 0,
      this.kali = 0.0});

  factory AmortisasiAsetDetail.fromJson(Map<String, dynamic> json) {
    return AmortisasiAsetDetail(
      id_detail: json['id_aset_detail'],
      id_amortisasi_aset: json['id_amortisasi_aset'],
      bulan: json['bulan'],
      tahun: json['tahun'],
      kali: json['kali_penyusutan']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_aset': this.id_amortisasi_aset,
      'bulan': this.bulan,
      'tahun': this.tahun,
      'kali_penyusutan': this.kali
    };
  }

  @override
  List<Object> get props => [id_detail, id_amortisasi_aset, bulan, tahun, kali];
}
