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
      keterangan: "Biaya Administrasi Pendaftaran",
      saat_perolehan: "78",
      masa_guna: "250.000",
      akun: "S1 Keperawatan",
      penyusutan: "3.250.000",
      akumulasi_penyusutan_tahun_lalu: "Ganjil",
      nilai_perolehan: "sds"),
];
