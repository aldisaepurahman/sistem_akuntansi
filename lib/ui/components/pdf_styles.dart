import 'dart:ui';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';

void cell_styling(PdfGrid grid) {
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      if (j != 0 && j != 1) {
        cell.stringFormat.alignment = PdfTextAlignment.right;
      }
      cell.style = PdfGridCellStyle(
          font: PdfStandardFont(PdfFontFamily.timesRoman, 9),
          cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5));
    }
  }
}

void center_style(PdfGridCell cell) {
  cell.stringFormat.alignment = PdfTextAlignment.center;
  cell.stringFormat.lineAlignment = PdfVerticalAlignment.middle;
  cell.style = PdfGridCellStyle(
      cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5),
      font: PdfStandardFont(
          style: PdfFontStyle.bold, PdfFontFamily.timesRoman, 9));
}

void right_style(PdfGridCell cell) {
  cell.stringFormat.alignment = PdfTextAlignment.right;
  cell.stringFormat.lineAlignment = PdfVerticalAlignment.middle;
  cell.style = PdfGridCellStyle(
      cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5),
      font: PdfStandardFont(
          style: PdfFontStyle.bold, PdfFontFamily.timesRoman, 9));
}

//==================================================================

void labarugi_header_style(PdfGridCell cell) {
  PdfBorders borders = new PdfBorders();
  borders.all = PdfPens.white;
  cell.stringFormat.alignment = PdfTextAlignment.left;
  cell.stringFormat.lineAlignment = PdfVerticalAlignment.middle;
  cell.style = PdfGridCellStyle(
      borders: borders,
      cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5),
      font: PdfStandardFont(
          style: PdfFontStyle.bold, PdfFontFamily.timesRoman, 11));
}

void labarugi_coa_style(PdfGridCell cell) {
  PdfBorders borders = new PdfBorders();
  borders.all = PdfPens.white;
  cell.stringFormat.alignment = PdfTextAlignment.left;
  cell.stringFormat.lineAlignment = PdfVerticalAlignment.middle;
  cell.style = PdfGridCellStyle(
      borders: borders,
      cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5),
      font: PdfStandardFont(PdfFontFamily.timesRoman, 11));
}

void labarugi_saldo_style(PdfGrid grid) {
  PdfBorders borders = new PdfBorders();
  borders.all = PdfPens.white;
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 1; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      cell.stringFormat.alignment = PdfTextAlignment.right;
      cell.stringFormat.lineAlignment = PdfVerticalAlignment.middle;
      cell.style = PdfGridCellStyle(
          borders: borders,
          cellPadding: PdfPaddings(bottom: 5, left: 5, right: 5, top: 5),
          font: PdfStandardFont(PdfFontFamily.timesRoman, 11));
    }
  }
}
