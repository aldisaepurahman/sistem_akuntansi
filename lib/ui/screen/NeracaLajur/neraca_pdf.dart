import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_akuntansi/model/response/vneraca_lajur.dart';
import 'package:sistem_akuntansi/ui/components/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';

Future<void> neraca_pdf(List<VNeracaLajur> list_neraca, String bulan, int tahun) async {
  String periode = '$bulan $tahun';

  PdfDocument document = PdfDocument();
  document.pageSettings.orientation = PdfPageOrientation.landscape;

  final PdfPage page = document.pages.add();
  final Size pageSize = page.getClientSize();

  header_laporan(page, pageSize, "LAPORAN NERACA SALDO", periode);

  PdfGrid grid = tabel_neraca_lajur(page, pageSize);

  list_neraca.forEach((neraca) {
    var neraca_saldo_debit = 0;
    var neraca_saldo_kredit = 0;
    var penyesuaian_debit = 0;
    var penyesuaian_kredit = 0;
    var ns_disesuaikan_debit = 0;
    var ns_disesuaikan_kredit = 0;
    var laba_debit = 0;
    var laba_kredit = 0;
    var neraca_debit = 0;
    var neraca_kredit = 0;

    if (neraca.kode_akun.contains("1.1") && neraca.keterangan.contains("Debit")) {
      if (neraca.neraca_saldo! >= 0) {
        neraca_saldo_debit = neraca.neraca_saldo!;
      } else {
        neraca_saldo_kredit = neraca.neraca_saldo!.abs();
      }

      if (neraca.saldo_jurnal_penyesuaian! >= 0) {
        penyesuaian_debit = neraca.saldo_jurnal_penyesuaian!;
      } else {
        penyesuaian_kredit = neraca.saldo_jurnal_penyesuaian!.abs();
      }

      if (neraca.neraca_saldo_disesuaikan! >= 0) {
        ns_disesuaikan_debit = neraca.neraca_saldo_disesuaikan!;
        neraca_debit = neraca.neraca_saldo_disesuaikan!;
      } else {
        ns_disesuaikan_kredit = neraca.neraca_saldo_disesuaikan!.abs();
        neraca_kredit = neraca.neraca_saldo_disesuaikan!.abs();
      }
    } else if (neraca.kode_akun.contains("1.2") && neraca.keterangan.contains("Kredit")) {
      if (neraca.neraca_saldo! < 0) {
        neraca_saldo_kredit = neraca.neraca_saldo!.abs();
      } else {
        neraca_saldo_debit = neraca.neraca_saldo!;
      }

      if (neraca.saldo_jurnal_penyesuaian! < 0) {
        penyesuaian_kredit = neraca.saldo_jurnal_penyesuaian!.abs();
      } else {
        penyesuaian_debit = neraca.saldo_jurnal_penyesuaian!;
      }

      if (neraca.neraca_saldo_disesuaikan! < 0) {
        ns_disesuaikan_kredit = neraca.neraca_saldo_disesuaikan!.abs();
        neraca_kredit = neraca.neraca_saldo_disesuaikan!.abs();
      } else {
        ns_disesuaikan_debit = neraca.neraca_saldo_disesuaikan!;
        neraca_debit = neraca.neraca_saldo_disesuaikan!;
      }
    } else if (neraca.kode_akun.contains("1.3") && neraca.keterangan.contains("Kredit")) {
      if (neraca.neraca_saldo! < 0) {
        neraca_saldo_kredit = neraca.neraca_saldo!.abs();
      } else {
        neraca_saldo_debit = neraca.neraca_saldo!;
      }

      if (neraca.saldo_jurnal_penyesuaian! < 0) {
        penyesuaian_kredit = neraca.saldo_jurnal_penyesuaian!.abs();
      } else {
        penyesuaian_debit = neraca.saldo_jurnal_penyesuaian!;
      }

      if (neraca.neraca_saldo_disesuaikan! < 0) {
        ns_disesuaikan_kredit = neraca.neraca_saldo_disesuaikan!.abs();
        neraca_kredit = neraca.neraca_saldo_disesuaikan!.abs();
      } else {
        ns_disesuaikan_debit = neraca.neraca_saldo_disesuaikan!;
        neraca_debit = neraca.neraca_saldo_disesuaikan!;
      }
    } else if (neraca.kode_akun.contains("2.4") && neraca.keterangan.contains("Kredit")) {
      if (neraca.neraca_saldo! < 0) {
        neraca_saldo_kredit = neraca.neraca_saldo!.abs();
      } else {
        neraca_saldo_debit = neraca.neraca_saldo!;
      }

      if (neraca.saldo_jurnal_penyesuaian! < 0) {
        penyesuaian_kredit = neraca.saldo_jurnal_penyesuaian!.abs();
      } else {
        penyesuaian_debit = neraca.saldo_jurnal_penyesuaian!;
      }

      if (neraca.neraca_saldo_disesuaikan! < 0) {
        ns_disesuaikan_kredit = neraca.neraca_saldo_disesuaikan!.abs();
        laba_kredit = neraca.neraca_saldo_disesuaikan!.abs();
      } else {
        ns_disesuaikan_debit = neraca.neraca_saldo_disesuaikan!;
        laba_debit = neraca.neraca_saldo_disesuaikan!;
      }
    } else if (neraca.kode_akun.contains("2.5") && neraca.keterangan.contains("Debit")) {
      if (neraca.neraca_saldo! >= 0) {
        neraca_saldo_debit = neraca.neraca_saldo!;
      } else {
        neraca_saldo_kredit = neraca.neraca_saldo!.abs();
      }

      if (neraca.saldo_jurnal_penyesuaian! >= 0) {
        penyesuaian_debit = neraca.saldo_jurnal_penyesuaian!;
      } else {
        penyesuaian_kredit = neraca.saldo_jurnal_penyesuaian!.abs();
      }

      if (neraca.neraca_saldo_disesuaikan! >= 0) {
        ns_disesuaikan_debit = neraca.neraca_saldo_disesuaikan!;
        laba_debit = neraca.neraca_saldo_disesuaikan!;
      } else {
        ns_disesuaikan_kredit = neraca.neraca_saldo_disesuaikan!.abs();
        laba_kredit = neraca.neraca_saldo_disesuaikan!.abs();
      }
    }

    add_data(grid, neraca.kode_akun, neraca.nama_akun, neraca_saldo_debit, neraca_saldo_kredit, penyesuaian_debit, penyesuaian_kredit,
        ns_disesuaikan_debit, ns_disesuaikan_kredit, laba_debit, laba_kredit, neraca_debit, neraca_kredit);
  });

  cell_styling(grid);
  jumlah_neraca(grid);
  hitung_balance(grid);

  grid.draw(page: page, bounds: Rect.fromLTWH(0, 143, pageSize.width, 0));
  List<int> bytes = await document.save();
  document.dispose();

  await FileSaveHelper.saveAndLaunchFile(bytes, 'NeracaLajur_$bulan$tahun.pdf');
}
