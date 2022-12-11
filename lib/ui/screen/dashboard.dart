import 'package:sistem_akuntansi/theme.dart';
import 'package:sistem_akuntansi/ui/components/card.dart';
import 'package:sistem_akuntansi/ui/components/sidebar.dart';
import 'package:sistem_akuntansi/ui/components/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var akun = "Sandra";

    return Scaffold(
      body: Row(
        children: [
          Navbar(),
          Expanded(
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
                      fontWeight: FontWeight.w500,
                      color: textColor,
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
                      color: greyColor,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        CardSaldo(total: "1.000.000"),
                        SizedBox(
                          width: 20,
                        ),
                        CardPemasukan(total: "1.000.000"),
                        SizedBox(
                          width: 20,
                        ),
                        CardPengeluaran(total: "1.000.000"),
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
          ),
        ],
      ),
    );
  }
}
