import 'package:flutter/cupertino.dart';

class AmortisasiPendapatan {
  String keterangan;
  String jumlah_mahasiswa;
  String total_harga;
  String akun;
  String penyusutan;
  String semester;

  AmortisasiPendapatan(
      {required this.keterangan,
      required this.jumlah_mahasiswa,
      required this.total_harga,
      required this.akun,
      required this.penyusutan,
      required this.semester});
}

List<AmortisasiPendapatan> content = [
  AmortisasiPendapatan(
      keterangan: "Biaya Administrasi Pendaftaran",
      jumlah_mahasiswa: "78",
      total_harga: "250.000",
      akun: "S1 Keperawatan",
      penyusutan: "3.250.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Biaya Operasional Pendidikan",
      jumlah_mahasiswa: "78",
      total_harga: "750.000",
      akun: "S1 Keperawatan",
      penyusutan: "9.750.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Uang Kuliah Teori",
      jumlah_mahasiswa: "78",
      total_harga: "2.960.000",
      akun: "S1 Keperawatan",
      penyusutan: "38.480.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Biaya Administrasi Pendaftaran",
      jumlah_mahasiswa: "9",
      total_harga: "250.000",
      akun: "S1 Keperawatan Non Reg",
      penyusutan: "375.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Biaya Operasional Pendidikan",
      jumlah_mahasiswa: "9",
      total_harga: "750.000",
      akun: "S1 Keperawatan Non Reg",
      penyusutan: "1.125.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Uang Kuliah Teori",
      jumlah_mahasiswa: "9",
      total_harga: "2.400.000",
      akun: "S1 Keperawatan Non Reg",
      penyusutan: "3.600.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Biaya Administrasi Pendaftaran",
      jumlah_mahasiswa: "21",
      total_harga: "250.000",
      akun: "D3 Keperawatan",
      penyusutan: "875.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Biaya Operasional Pendidikan",
      jumlah_mahasiswa: "21",
      total_harga: "750.000",
      akun: "D3 Keperawatan",
      penyusutan: "2.625.000",
      semester: "Ganjil"),
  AmortisasiPendapatan(
      keterangan: "Uang Kuliah Teori",
      jumlah_mahasiswa: "21",
      total_harga: "2.560.000",
      akun: "D3 Keperawatan",
      penyusutan: "8.960.000",
      semester: "Ganjil"),
];
