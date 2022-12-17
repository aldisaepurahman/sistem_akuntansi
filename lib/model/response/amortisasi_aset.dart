import 'package:equatable/equatable.dart';

class AmortisasiAset extends Equatable {
  String id_amortisasi_aset;
  String id_amortisasi_akun;
  String keterangan;
  int masa_guna;
  int nilai_awal;
  int akumulasi;
  int penyusutan;
  int tahun;
  int tahun_perolehan;
  String bulan_perolehan;
  int persentase_bunga;

  AmortisasiAset(
      {this.id_amortisasi_aset = "",
      this.id_amortisasi_akun = "",
      this.keterangan = "",
      this.masa_guna = 0,
      this.nilai_awal = 0,
      this.akumulasi = 0,
      this.penyusutan = 0,
      this.tahun = 0,
        this.tahun_perolehan = 0,
        this.bulan_perolehan = "",
        this.persentase_bunga = 0
      });

  factory AmortisasiAset.fromJson(Map<String, dynamic> json) {
    return AmortisasiAset(
        id_amortisasi_aset: json['id_amortisasi_aset'],
        id_amortisasi_akun: json['id_amortisasi_akun'],
        keterangan: json['keterangan'],
        masa_guna: json['masa_guna'],
        nilai_awal: json['perolehan_nilai_awal'],
        akumulasi: json['akumulasi_tahun_lalu'],
        penyusutan: json['penyusutan'],
      tahun: json['tahun_input'],
      tahun_perolehan: json['tahun_perolehan'],
      bulan_perolehan: json['bulan_perolehan'],
      persentase_bunga: json['persentase_bunga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_amortisasi_aset': this.id_amortisasi_aset,
      'id_amortisasi_akun': this.id_amortisasi_akun,
      'keterangan': this.keterangan,
      'masa_guna': this.masa_guna,
      'perolehan_nilai_awal': this.nilai_awal,
      'akumulasi_tahun_lalu': this.akumulasi,
      'penyusutan': this.penyusutan,
      'tahun_input': this.tahun,
      'tahun_perolehan': this.tahun_perolehan,
      'bulan_perolehan': this.bulan_perolehan,
      'persentase_bunga': this.persentase_bunga,
    };
  }

  @override
  List<Object> get props => [
        id_amortisasi_akun,
        id_amortisasi_aset,
        keterangan,
        masa_guna,
        nilai_awal,
        akumulasi,
        penyusutan,
  tahun,
  tahun_perolehan,
  bulan_perolehan,
    persentase_bunga
      ];
}
