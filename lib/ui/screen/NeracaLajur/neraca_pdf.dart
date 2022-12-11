import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_akuntansi/ui/components/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';

Future<void> neraca_pdf() async {
  String periode = '31 Maret 2022';

  PdfDocument document = PdfDocument();
  document.pageSettings.orientation = PdfPageOrientation.landscape;

  final PdfPage page = document.pages.add();
  final Size pageSize = page.getClientSize();

  header_laporan(page, pageSize, "LAPORAN NERACA SALDO", periode);

  PdfGrid grid = tabel_neraca_lajur(page, pageSize);

  add_data(grid, "1.1-1101-01-01", "Uang Tunai (Bendahara)", 24237450, 0, 0, 0,
      24237450, 0, 0, 0, 24237450, 0);
  add_data(
      grid,
      "1.1-1101-02-01-01",
      "Rekening Tabungan Bank BRI 0656-01-000033-56-9",
      31863806,
      0,
      0,
      0,
      31863806,
      0,
      0,
      0,
      31863806,
      0);
  add_data(
      grid,
      "1.1-1101-02-01-02",
      "Rekening Tabungan Bank BNI 055 - 046 - 7375",
      189757400,
      0,
      0,
      0,
      189757400,
      0,
      0,
      0,
      189757400,
      0);
  add_data(
      grid,
      "1.1-1101-02-02-01",
      "Rekening Giro Bank NISP Rek. 015-800-00058-8",
      115220248,
      0,
      0,
      0,
      115220248,
      0,
      0,
      0,
      115220248,
      0);
  add_data(
      grid,
      "1.1-1104-01-01-01-02-02",
      "Piutang Mahasiswa angkatan 2013/2014 S1 Keperawatan",
      36300000,
      0,
      0,
      0,
      36300000,
      0,
      0,
      0,
      36300000,
      0);
  add_data(
      grid,
      "1.1-1104-01-01-01-03-08",
      "Piutang Mahasiswa angkatan 2021/2022 S1 Keperawatan",
      185761220,
      0,
      0,
      0,
      185761220,
      0,
      0,
      0,
      185761220,
      0);
  add_data(
      grid,
      "1.2-2102-01-02-03",
      "Pendapatan diterima di muka Angkatan 2017/2018 S1 Keperawatan",
      0,
      82694800,
      0,
      0,
      0,
      82694800,
      0,
      0,
      0,
      82694800);
  add_data(
      grid,
      "1.2-2102-01-02-04",
      "Pendapatan diterima di muka Angkatan 2018/2019 S1 Keperawatan",
      0,
      101257200,
      0,
      0,
      0,
      101257200,
      0,
      0,
      0,
      101257200);
  add_data(
      grid,
      "1.2-2102-01-02-06",
      "Pendapatan diterima di muka Angkatan 2019/2020 S1 Keperawatan",
      0,
      121877850,
      0,
      0,
      0,
      121877850,
      0,
      0,
      0,
      121877850);
  add_data(
      grid,
      "2.4-4101-02-01-01",
      "Pendapatan Administrasi Pendaftaran S1 Keperawatan",
      0,
      15958333,
      0,
      0,
      0,
      15958333,
      0,
      15958333,
      0,
      0);
  add_data(
      grid,
      "2.4-4101-02-01-02",
      "Pendapatan Administrasi Pendaftaran D3 Keperawatan",
      0,
      3375000,
      0,
      0,
      0,
      3375000,
      0,
      3375000,
      0,
      0);
  add_data(
      grid,
      "2.4-4101-02-01-03",
      "Pendapatan Administrasi Pendaftaran D3 Perekam & Inf. Kes",
      0,
      6791667,
      0,
      0,
      0,
      6791667,
      0,
      6791667,
      0,
      0);
  add_data(
      grid,
      "2.4-4101-02-07-01",
      "Pendapatan Dana Pengembangan Pendidikan ( DPP ) S1 Keperawatan",
      0,
      90958333,
      0,
      0,
      0,
      90958333,
      0,
      90958333,
      0,
      0);
  add_data(grid, "2.5-5101-01-01-01", "Beban Gaji Pokok S1 Keperawatan", 0,
      54563675, 0, 0, 0, 54563675, 0, 54563675, 0, 0);
  add_data(grid, "2.5-5101-01-01-02", "Beban Gaji Pokok D3 Keperawatan", 0,
      27578341, 0, 0, 0, 27578341, 0, 27578341, 0, 0);
  add_data(grid, "2.5-5101-01-01-03", "Beban Gaji Pokok D3 Perekam & Inf. Kes",
      0, 28629253, 0, 0, 0, 28629253, 0, 28629253, 0, 0);
  add_data(grid, "2.5-5101-01-01-04", "Beban Gaji Pokok D3 Farmasi", 0,
      18757996, 0, 0, 0, 18757996, 0, 18757996, 0, 0);

  cell_styling(grid);
  jumlah_neraca(grid);
  hitung_balance(grid);

  grid.draw(page: page, bounds: Rect.fromLTWH(0, 143, pageSize.width, 0));
  List<int> bytes = await document.save();
  document.dispose();

  await FileSaveHelper.saveAndLaunchFile(bytes, 'NeracaLajur_Maret2022.pdf');
}
