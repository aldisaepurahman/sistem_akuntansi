import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_akuntansi/ui/components/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';

Future<void> labarugi_pdf() async {
  String periode = '31 Maret 2022';

  PdfDocument document = PdfDocument();

  final PdfPage page = document.pages.add();
  final Size pageSize = page.getClientSize();

  header_laporan(page, pageSize, "LAPORAN LABA RUGI", periode);

  page.graphics.drawString("Periode : " + periode,
      PdfStandardFont(PdfFontFamily.timesRoman, 11, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(0, 125, pageSize.width, 15),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));

  PdfGrid grid = tabel_neraca_lajur(page, pageSize);

  grid.draw(page: page, bounds: Rect.fromLTWH(0, 143, pageSize.width, 0));
  List<int> bytes = await document.save();
  document.dispose();

  await FileSaveHelper.saveAndLaunchFile(bytes, 'NeracaLajur_Maret2022.pdf');
}

//cellStyle.Borders.Bottom.Color = new PdfColor(Color.Transparent); 
