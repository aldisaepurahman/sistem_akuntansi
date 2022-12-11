import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/card.dart';
import 'package:sistem_akuntansi/ui/components/table.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var akun = "Sandra";

    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang, ' + akun + '!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textColor,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Berikut catatan pemasukan dan pengeluaran keuangan untuk periode ini',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: greyFontColor,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 32,
            ),
            FittedBox(
              child: Row(
                children: [
                  CardSaldo(
                    total: "Rp " + "1.000.000",
                    fontColor: textColor,
                    bgColor: yellowTextColor,
                    textCard: "Total Saldo",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CardSaldo(
                    total: "+ Rp " + "1.000.000",
                    fontColor: greenColor,
                    bgColor: whiteColor,
                    textCard: "Total Pemasukan",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CardSaldo(
                    total: "- Rp " + "1.000.000",
                    fontColor: redColor,
                    bgColor: whiteColor,
                    textCard: "Total Pengeluaran",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Riwayat Transaksi",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TableDashboard(
                    tanggal: "29/11",
                    nama_transaksi: "Pembayaran SPP",
                    keterangan: "Debit",
                    saldo: "1.000.000",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}