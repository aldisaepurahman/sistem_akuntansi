import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_akuntansi/ui/components/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';

Future<void> labarugi_pdf() async {
  var total_beban, total_pendapatan, total_laba;
  String periode = '31 Maret 2022';

  PdfDocument document = PdfDocument();

  final PdfPage page = document.pages.add();
  final Size pageSize = page.getClientSize();

  header_laporan(page, pageSize, "LAPORAN LABA RUGI", periode);

  //PENDAPATAN
  PdfGrid grid_pendapatan = PdfGrid();
  grid_pendapatan.columns.add(count: 4);
  grid_pendapatan.columns[0].width = 230;

  add_data_labarugi(grid_pendapatan, "Pendapatan Jasa", 0, 678379000);
  add_data_labarugi(grid_pendapatan, "Retur dan Potongan", 2000000, 0);
  add_data_labarugi(grid_pendapatan, "Diskon Penjualan", -500000, 0);
  total_pendapatan = laba_rugi_hitung_saldo(
      grid_pendapatan, "Pendapatan Bersih", total_pendapatan);
  labarugi_saldo_style(grid_pendapatan);

  //BEBAN
  PdfGrid grid_beban = PdfGrid();
  grid_beban.columns.add(count: 4);
  grid_beban.columns[0].width = 230;

  add_data_labarugi(grid_beban, "Beban Gaji", 108951000, 0);
  add_data_labarugi(grid_beban, "Beban Sewa", 2751000, 0);
  add_data_labarugi(grid_beban, "Beban Asuransi", 45900000, 0);
  add_data_labarugi(grid_beban, "Beban Listrik", 2897000, 0);
  total_beban = laba_rugi_hitung_saldo(grid_beban, "Total Beban", total_beban);

  labarugi_saldo_style(grid_beban);

  total_laba = total_pendapatan + total_beban;

  if (total_laba > 0) {
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(99, 231, 106)),
        bounds: Rect.fromLTWH(0, 143, pageSize.width, 40));
    page.graphics.drawString("LABA : Rp" + total_laba.toString(),
        PdfStandardFont(PdfFontFamily.timesRoman, 14, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(10, 150, 250, 25),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
  } else if (total_laba < 0) {
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(225, 60, 60)),
        bounds: Rect.fromLTWH(0, 143, pageSize.width, 40));
    page.graphics.drawString("RUGI : Rp" + total_laba.toString(),
        PdfStandardFont(PdfFontFamily.timesRoman, 14, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(10, 150, 250, 25),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle));
  }

  PdfLayoutResult? result = PdfTextElement(
          text: "Pendapatan",
          font: new PdfStandardFont(PdfFontFamily.timesRoman, 11,
              style: PdfFontStyle.bold))
      .draw(
          page: page,
          bounds: Rect.fromLTWH(0, 205, pageSize.width, pageSize.height));

  result = grid_pendapatan.draw(
      page: result!.page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 10, pageSize.width, 0));

  result = PdfTextElement(
          text: "Beban Usaha",
          font: new PdfStandardFont(PdfFontFamily.timesRoman, 11,
              style: PdfFontStyle.bold))
      .draw(
          page: result!.page,
          bounds: Rect.fromLTWH(
              0, result.bounds.bottom + 20, pageSize.width, pageSize.height));

  result = grid_beban.draw(
      page: result!.page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 10, pageSize.width, 0));

  result = PdfTextElement(
          text: "Laba Bersih",
          font: new PdfStandardFont(PdfFontFamily.timesRoman, 12,
              style: PdfFontStyle.bold))
      .draw(
          page: result!.page,
          bounds: Rect.fromLTWH(
              0, result.bounds.bottom + 20, pageSize.width, pageSize.height));

  result = PdfTextElement(
          format: PdfStringFormat(alignment: PdfTextAlignment.right),
          text: total_laba.toString(),
          font: new PdfStandardFont(PdfFontFamily.timesRoman, 12,
              style: PdfFontStyle.bold))
      .draw(
          page: result!.page,
          bounds: Rect.fromLTWH(
              0, result.bounds.bottom - 12, pageSize.width, pageSize.height));

  print(total_laba);

  List<int> bytes = await document.save();
  document.dispose();

  await FileSaveHelper.saveAndLaunchFile(bytes, 'LabaRugi_Maret2022.pdf');
}