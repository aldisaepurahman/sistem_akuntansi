import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/screen/LabaRugi/labarugi_pdf.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

import '../../../utils/V_LabaRugi.dart';

class LaporanLabaRugi extends StatefulWidget {
  final SupabaseClient client;

  const LaporanLabaRugi({required this.client, Key? key}) : super(key: key);

  @override
  LaporanLabaRugiState createState() {
    return LaporanLabaRugiState();
  }

  static int hitung_jumlah(List<Map> data, String column) {
    int total = 0;
    data.forEach((item) {
      total += item[column] as int;
    });

    return total;
  }
}

class LaporanLabaRugiState extends State<LaporanLabaRugi> {
  @override
  void dispose() {}

  int total_debit_pendapatan =
      LaporanLabaRugi.hitung_jumlah(pendapatan, 'debit');
  int total_kredit_pendapatan =
      LaporanLabaRugi.hitung_jumlah(pendapatan, 'kredit');

  int total_debit_beban = LaporanLabaRugi.hitung_jumlah(beban, 'debit');
  int total_kredit_beban = LaporanLabaRugi.hitung_jumlah(beban, 'kredit');

  List<DataRow> _createRows(List<Map> item) {
    return item
        .map((item) => DataRow(cells: [
              DataCell(SizedBox(
                width: MediaQuery.of(context).size.width / 5 - 50,
                child: Container(
                  child: Text(
                    item["nama_akun"],
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              )),
              DataCell(SizedBox(
                width: MediaQuery.of(context).size.width / 5 - 50,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item["debit"].toString(),
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              )),
              DataCell(SizedBox(
                width: MediaQuery.of(context).size.width / 5 - 50,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item["kredit"].toString(),
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              )),
              DataCell(SizedBox(
                width: MediaQuery.of(context).size.width / 5 - 50,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ))
            ]))
        .toList();
  }

  String periode = "31 Maret 2022";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Laporan Laba Rugi',
        home: Scaffold(
            backgroundColor: background,
            body: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ButtonBack(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25),
                    child: HeaderText(
                        content: "Laporan Laba Rugi", size: 32, color: hitam)),
                Container(
                    margin: EdgeInsets.only(bottom: 15, left: 25),
                    child: HeaderText(
                        content: "Bulan Maret 2022", size: 18, color: hitam)),
                Container(
                  margin: EdgeInsets.only(
                      top: 25, bottom: 150, right: 25, left: 25),
                  padding: EdgeInsets.all(25),
                  color: background2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: labarugi_pdf,
                              content: "Cetak Laporan")
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            "STIKes Santo Borromeus",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Inner",
                                fontSize: 15,
                                color: hitam,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "Laporan Laba Rugi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Inner",
                                fontSize: 15,
                                color: hitam,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 5, bottom: 25),
                          child: Text(
                            "Periode " + periode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Inner",
                                fontSize: 15,
                                color: hitam),
                          )),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                        width: double.infinity,
                        color: kuning,
                        child: Text(
                            "Laba : Rp" +
                                ((total_kredit_pendapatan -
                                            total_debit_pendapatan) +
                                        (total_kredit_beban -
                                            total_debit_beban))
                                    .toString(),
                            style: TextStyle(
                                fontFamily: "Inner",
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: hitam)),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            child: DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text("Pendapatan"),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                              ],
                              showCheckboxColumn: false,
                              rows: _createRows(pendapatan),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Pendapatan Bersih",
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam)),
                                Text(
                                    (total_kredit_pendapatan -
                                            total_debit_pendapatan)
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: double.infinity,
                            child: DataTable(
                              columns: <DataColumn>[
                                DataColumn(
                                  label: Text("Beban Usaha"),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                              ],
                              showCheckboxColumn: false,
                              rows: _createRows(beban),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Total Beban",
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam)),
                                Text(
                                    (total_kredit_beban - total_debit_beban)
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Laba Bersih",
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam)),
                                Text(
                                    ((total_kredit_pendapatan -
                                                total_debit_pendapatan) +
                                            (total_kredit_beban -
                                                total_debit_beban))
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: hitam))
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
