import 'package:equatable/equatable.dart';

class AmortisasiPendapatanDetail extends Equatable {
  int id_detail;
  String id_amortisasi_pendapatan;
  String bulan;
  int tahun;
  double kali;

  AmortisasiPendapatanDetail(
      {this.id_detail = 0,
      this.id_amortisasi_pendapatan = "",
      this.bulan = "",
      this.tahun = 0,
      this.kali = 0.0});

  factory AmortisasiPendapatanDetail.fromJson(Map<String, dynamic> json) {
    return AmortisasiPendapatanDetail(
      id_detail: json['id_pendapatan_detail'],
      id_amortisasi_pendapatan: json['id_amortisasi_pendapatan'],
      bulan: json['bulan'],
      tahun: json['tahun'],
      kali: json['kali_penyusutan']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_pendapatan': this.id_amortisasi_pendapatan,
      'bulan': this.bulan,
      'tahun': this.tahun,
      'kali_penyusutan': this.kali
    };
  }

  @override
  List<Object> get props => [id_detail, id_amortisasi_pendapatan, bulan, tahun, kali];
}
