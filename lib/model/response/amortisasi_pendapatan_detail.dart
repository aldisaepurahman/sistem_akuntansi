import 'package:equatable/equatable.dart';

class AmortisasiPendapatanDetail extends Equatable {
  String id_detail;
  String id_amortisasi_pendapatan;
  String bulan;
  int tahun;
  int nominal_penyusutan;

  AmortisasiPendapatanDetail(
      {this.id_detail = "",
      this.id_amortisasi_pendapatan = "",
      this.bulan = "",
      this.tahun = 0,
      this.nominal_penyusutan = 0});

  factory AmortisasiPendapatanDetail.fromJson(Map<String, dynamic> json) {
    return AmortisasiPendapatanDetail(
      id_detail: json['id_pendapatan_detail'],
      id_amortisasi_pendapatan: json['id_amortisasi_pendapatan'],
      bulan: json['bulan'],
      tahun: json['tahun'],
        nominal_penyusutan: json['nominal_penyusutan'].toInt()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pendapatan_detail': this.id_detail,
      'id_amortisasi_pendapatan': this.id_amortisasi_pendapatan,
      'bulan': this.bulan,
      'tahun': this.tahun,
      'nominal_penyusutan': this.nominal_penyusutan
    };
  }

  @override
  List<Object> get props => [id_detail, id_amortisasi_pendapatan, bulan, tahun, nominal_penyusutan];
}
