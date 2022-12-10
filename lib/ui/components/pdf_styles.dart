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
