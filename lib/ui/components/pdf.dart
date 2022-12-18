import 'package:sistem_akuntansi/utils/currency_format.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sistem_akuntansi/ui/components/pdf_styles.dart';
import 'package:sistem_akuntansi/ui/screen/LabaRugi/labarugi_pdf.dart';

class FileSaveHelper {
  static const MethodChannel _platformCall = MethodChannel('launchFile');

  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory = await getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      final Map<String, String> argument = <String, String>{
        'file_path': '$path/$fileName'
      };
      try {
        //ignore: unused_local_variable
        final Future<Map<String, String>?> result =
            _platformCall.invokeMethod('viewPdf', argument);
      } catch (e) {
        throw Exception(e);
      }
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'],
          runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }
}

void add_data(
    PdfGrid grid,
    String kode,
    String nama_akun,
    int ns_debit,
    int ns_kredit,
    int penyesuaian_debit,
    int penyesuaian_kredit,
    int nsDisesuai_debit,
    int nsDisesuai_kredit,
    int lr_debit,
    int lr_kredit,
    int nrc_debit,
    int nrc_kredit) {
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = kode;
  row.cells[1].value = nama_akun;
  row.cells[2].value = CurrencyFormat.convertToCurrency(ns_debit);
  row.cells[3].value = CurrencyFormat.convertToCurrency(ns_kredit);
  row.cells[4].value = CurrencyFormat.convertToCurrency(penyesuaian_debit);
  row.cells[5].value = CurrencyFormat.convertToCurrency(penyesuaian_kredit);
  row.cells[6].value = CurrencyFormat.convertToCurrency(nsDisesuai_debit);
  row.cells[7].value = CurrencyFormat.convertToCurrency(nsDisesuai_kredit);
  row.cells[8].value = CurrencyFormat.convertToCurrency(lr_debit);
  row.cells[9].value = CurrencyFormat.convertToCurrency(lr_kredit);
  row.cells[10].value = CurrencyFormat.convertToCurrency(nrc_debit);
  row.cells[11].value = CurrencyFormat.convertToCurrency(nrc_kredit);
}

PdfPage header_laporan(
    PdfPage page, Size pageSize, String nama_laporan, String periode) {
  final Uint8List imageData =
      File('assets/images/logo_stikes.png').readAsBytesSync();
  final PdfBitmap image = PdfBitmap(imageData);

  page.graphics.drawImage(image, Rect.fromLTWH(30, 0, 90, 90));
  page.graphics.drawString("STIKes Santo Borromeus",
      PdfStandardFont(PdfFontFamily.timesRoman, 14, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(100, 15, pageSize.width - 90, 20),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(nama_laporan,
      PdfStandardFont(PdfFontFamily.timesRoman, 14, style: PdfFontStyle.bold),
      bounds: Rect.fromLTWH(100, 35, pageSize.width - 90, 20),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(
      "Periode " + periode, PdfStandardFont(PdfFontFamily.timesRoman, 14),
      bounds: Rect.fromLTWH(100, 55, pageSize.width - 90, 20),
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 110, pageSize.width, 2),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

  return page;
}

PdfGrid tabel_neraca_lajur(PdfPage page, Size pageSize) {
  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 12);
  PdfGridRow header = grid.headers.add(2)[0];
  header.cells[0].value = 'Kode Akun';
  header.cells[1].value = 'Nama Akun';
  header.cells[2].value = 'Neraca Saldo';
  header.cells[4].value = 'Penyesuaian';
  header.cells[6].value = 'NS Disesuaikan';
  header.cells[8].value = 'Laba Rugi';
  header.cells[10].value = 'Neraca';

  header.cells[2].columnSpan = 2;
  header.cells[4].columnSpan = 2;
  header.cells[6].columnSpan = 2;
  header.cells[8].columnSpan = 2;
  header.cells[10].columnSpan = 2;

  header.cells[0].rowSpan = 2;
  header.cells[1].rowSpan = 2;
  grid.columns[1].width = 80;

  header = grid.headers.add(2)[1];
  header.cells[2].value = 'Debit';
  header.cells[3].value = 'Kredit';
  header.cells[4].value = 'Debit';
  header.cells[5].value = 'Kredit';
  header.cells[6].value = 'Debit';
  header.cells[7].value = 'Kredit';
  header.cells[8].value = 'Debit';
  header.cells[9].value = 'Kredit';
  header.cells[10].value = 'Debit';
  header.cells[11].value = 'Kredit';

  for (int i = 0; i < grid.headers.count; i++) {
    final PdfGridRow header = grid.headers[i];
    for (int j = 0; j < header.cells.count; j++) {
      header.cells[j].style = PdfGridCellStyle(
          font: PdfStandardFont(PdfFontFamily.timesRoman, 9,
              style: PdfFontStyle.bold),
          cellPadding: PdfPaddings(left: 5, right: 5));
      header.cells[j].stringFormat.alignment = PdfTextAlignment.center;
      header.cells[j].stringFormat.lineAlignment = PdfVerticalAlignment.middle;
    }
  }

  return grid;
}

void jumlah_neraca(PdfGrid grid) {
  PdfGridRow row = grid.rows.add();

  row.cells[0].columnSpan = 2;
  row.cells[0].value = 'Jumlah';
  center_style(row.cells[0]);

  for (int i = 2; i < row.cells.count; i++) {
    PdfGridCell cell = row.cells[i];
    var total = total_saldo(grid, i);
    cell.value = CurrencyFormat.convertToCurrency(total);
    right_style(cell);
  }
}

void hitung_balance(PdfGrid grid) {
  PdfGridRow row = grid.rows.add();
  PdfGridRow row2 = grid.rows.add();

  row.cells[6].value = 'Rugi Usaha (EBIT)';
  row.cells[0].columnSpan = 6;
  row.cells[0].rowSpan = 2;
  row.cells[6].columnSpan = 2;
  row2.cells[6].columnSpan = 2;
  center_style(row.cells[6]);
  center_style(row2.cells[6]);

  int total_row = grid.rows.count - 3;

  var grid_lr_debit = grid.rows[total_row].cells[8].value as String;
  var grid_lr_kredit = grid.rows[total_row].cells[9].value as String;
  var grid_nrc_debit = grid.rows[total_row].cells[10].value as String;
  var grid_nrc_kredit = grid.rows[total_row].cells[11].value as String;

  grid_lr_debit = grid_lr_debit.replaceAll(".", "");
  grid_lr_kredit = grid_lr_kredit.replaceAll(".", "");
  grid_nrc_debit = grid_nrc_debit.replaceAll(".", "");
  grid_nrc_kredit = grid_nrc_kredit.replaceAll(".", "");

  int lr_debit = int.parse(grid_lr_debit);
  int lr_kredit = int.parse(grid_lr_kredit);
  int nrc_debit = int.parse(grid_nrc_debit);
  int nrc_kredit = int.parse(grid_nrc_kredit);

  var hitung_lr_debit, hitung_lr_kredit, hitung_nrc_debit, hitung_nrc_kredit;

  if (lr_debit > lr_kredit) {
    hitung_lr_debit = 0;
    hitung_lr_kredit = lr_debit - lr_kredit;
    row.cells[8].value = CurrencyFormat.convertToCurrency(hitung_lr_debit);
    row.cells[9].value = CurrencyFormat.convertToCurrency(hitung_lr_kredit);
  } else if (lr_kredit > lr_debit) {
    hitung_lr_debit = lr_kredit - lr_debit;
    hitung_lr_kredit = 0;
    row.cells[8].value = CurrencyFormat.convertToCurrency(hitung_lr_debit);
    row.cells[9].value = CurrencyFormat.convertToCurrency(hitung_lr_kredit);
  }

  if (nrc_debit > nrc_kredit) {
    hitung_nrc_debit = 0;
    hitung_nrc_kredit = nrc_debit - nrc_kredit;
    row.cells[10].value = CurrencyFormat.convertToCurrency(hitung_nrc_debit);
    row.cells[11].value = CurrencyFormat.convertToCurrency(hitung_nrc_kredit);
  } else if (nrc_kredit > nrc_debit) {
    hitung_nrc_debit = nrc_kredit - nrc_debit;
    hitung_nrc_kredit = 0;
    row.cells[10].value = CurrencyFormat.convertToCurrency(hitung_nrc_debit);
    row.cells[11].value = CurrencyFormat.convertToCurrency(hitung_nrc_kredit);
  }

  for (int i = 8; i < 12; i++) {
    right_style(row.cells[i]);
    right_style(row2.cells[i]);
  }

  //=========================================================

  var balance_lr_debit,
      balance_lr_kredit,
      balance_nrc_debit,
      balance_nrc_kredit;

  balance_lr_debit = lr_debit + hitung_lr_debit;
  balance_lr_kredit = lr_kredit + hitung_lr_kredit;
  balance_nrc_debit = nrc_debit + hitung_nrc_debit;
  balance_nrc_kredit = nrc_kredit + hitung_nrc_kredit;

  row2.cells[8].value = CurrencyFormat.convertToCurrency(balance_lr_debit);
  row2.cells[9].value = CurrencyFormat.convertToCurrency(balance_lr_kredit);

  row2.cells[10].value = CurrencyFormat.convertToCurrency(balance_nrc_debit);
  row2.cells[11].value = CurrencyFormat.convertToCurrency(balance_nrc_kredit);

  if ((balance_lr_debit == balance_lr_kredit) &&
      (balance_nrc_debit == balance_nrc_kredit)) {
    row2.cells[6].value = 'BALANCE';
  } else {
    row2.cells[6].value = 'TIDAK BALANCE!!! PERIKSA';
  }
}

int total_saldo(PdfGrid grid, int i) {
  int total = 0;
  for (int j = 0; j < grid.rows.count - 1; j++) {
    String value = grid.rows[j].cells[i].value as String;
    value = value.replaceAll(".", "");
    total += int.parse(value);
  }
  return total;
}

//==================================================================

void add_data_labarugi(PdfGrid grid, String nama_akun, int debit, int kredit) {
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = nama_akun;
  labarugi_coa_style(row.cells[0]);

  if (debit > 0 || debit < 0) {
    row.cells[1].value = CurrencyFormat.convertToCurrency(debit);
  } else {
    row.cells[1].value = CurrencyFormat.convertToCurrency(0);
  }

  if (kredit > 0 || kredit < 0) {
    row.cells[2].value = CurrencyFormat.convertToCurrency(kredit);
  } else {
    row.cells[2].value = CurrencyFormat.convertToCurrency(0);
  }
}

int laba_rugi_hitung_saldo(PdfGrid grid, String nama_kolom, var jumlah) {
  int debit = 0, kredit = 0;

  PdfGridRow row = grid.rows.add();
  row.cells[0].value = nama_kolom;
  labarugi_header_style(row.cells[0]);

  for (int j = 0; j < grid.rows.count - 1; j++) {
    String value = grid.rows[j].cells[1].value as String;
    String value2 = grid.rows[j].cells[2].value as String;
    value = value.replaceAll(".", "");
    value2 = value2.replaceAll(".", "");

    debit += int.parse(value);
    kredit += int.parse(value2);
  }

  jumlah = kredit - debit;

  if (jumlah > 0 || jumlah < 0) {
    row.cells[3].value = CurrencyFormat.convertToCurrency(jumlah);
  } else {
    row.cells[3].value = CurrencyFormat.convertToCurrency(0);
  }

  return jumlah;
}
