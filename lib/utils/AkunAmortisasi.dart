import 'package:flutter/cupertino.dart';

class AkunAmortisasi {
  String akun;

  AkunAmortisasi({required this.akun});
}

List<AkunAmortisasi> content_akun = [
  AkunAmortisasi(akun: "Peralatan Laboratorium"),
  AkunAmortisasi(akun: "Kendaraan"),
  AkunAmortisasi(akun: "Bangunan"),
];
