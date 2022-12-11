import 'package:flutter/cupertino.dart';

class AmortisasiAset {
  String keterangan;
  String saat_perolehan;
  String masa_guna;
  String nilai_perolehan;
  String penyusutan;
  String akumulasi_penyusutan_tahun_lalu;
  String akun;

  AmortisasiAset(
      {required this.keterangan,
      required this.saat_perolehan,
      required this.masa_guna,
      required this.akun,
      required this.penyusutan,
      required this.akumulasi_penyusutan_tahun_lalu,
      required this.nilai_perolehan});
}

List<AmortisasiAset> content = [
  AmortisasiAset(
      keterangan: "EYE,5 TIMESFULL-SIZE - HIBAH PHP PTS 2013",
      saat_perolehan: "Desember'13",
      masa_guna: "4",
      akun: "Peralatan Laboratorium",
      penyusutan: "327.708",
      akumulasi_penyusutan_tahun_lalu: "15.730.000",
      nilai_perolehan: "15.730.000"),
  AmortisasiAset(
      keterangan: "NEBULIZER ULTRASONIC - HIBAH PHP PTS 2013",
      saat_perolehan: "Desember'13",
      masa_guna: "4",
      akun: "Peralatan Laboratorium",
      penyusutan: "229.167",
      akumulasi_penyusutan_tahun_lalu: "11.000.000",
      nilai_perolehan: "11.000.000"),
  AmortisasiAset(
      keterangan: "AC SPLIT 2PK",
      saat_perolehan: "November'13",
      masa_guna: "4",
      akun: "Peralatan",
      penyusutan: "155.776",
      akumulasi_penyusutan_tahun_lalu: "7.477.250",
      nilai_perolehan: "7.477.250"),
  AmortisasiAset(
      keterangan: "Pembelian Buku-Buku di Perpustakaan",
      saat_perolehan: "Desember'22",
      masa_guna: "4",
      akun: "Peralatan",
      penyusutan: "151.813",
      akumulasi_penyusutan_tahun_lalu: "0",
      nilai_perolehan: "7.287.000"),
];
