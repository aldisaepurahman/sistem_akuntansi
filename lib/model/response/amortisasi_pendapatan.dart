import 'package:equatable/equatable.dart';

class AmortisasiPendapatan extends Equatable {
  String id_pendapatan;
  String id_amortisasi_akun;
  int jumlah;
  String keterangan;
  int jumlah_mhs;
  String semester;
  int penyusutan;

  AmortisasiPendapatan(
      {this.id_pendapatan = "",
      this.id_amortisasi_akun = "",
      this.jumlah = 0,
      this.keterangan = "",
      this.jumlah_mhs = 0,
      this.semester = "",
      this.penyusutan = 0});

  factory AmortisasiPendapatan.fromJson(Map<String, dynamic> json) {
    return AmortisasiPendapatan(
        id_pendapatan: json['id_amortisasi_pendapatan'],
        id_amortisasi_akun: json['id_amortisasi_akun'],
        jumlah: json['jumlah'],
        keterangan: json['keterangan'],
        jumlah_mhs: json['jumlah_mahasiswa'],
        semester: json['semester'],
        penyusutan: json['penyusutan']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_pendapatan': this.id_pendapatan,
      'id_amortisasi_akun': this.id_amortisasi_akun,
      'jumlah': this.jumlah,
      'keterangan': this.keterangan,
      'jumlah_mahasiswa': this.jumlah_mhs,
      'semester': this.semester,
      'penyusutan': this.penyusutan
    };
  }

  @override
  List<Object> get props => [
    id_pendapatan,
    id_amortisasi_akun,
    jumlah,
    keterangan,
    jumlah_mhs,
    semester,
    penyusutan
  ];
}
