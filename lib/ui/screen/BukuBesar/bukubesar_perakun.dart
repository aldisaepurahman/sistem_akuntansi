import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/Buku_besar.dart';

class BukuBesarPerAkun extends StatefulWidget {
  BukuBesarPerAkun({Key? key}) : super(key: key);

  @override
  BukuBesarPerAkunState createState() {
    return BukuBesarPerAkunState();
  }
}

class BukuBesarPerAkunState extends State<BukuBesarPerAkun> {
  var tableRow;
  final textAkunController = TextEditingController(text: '');
  String hintText = 'Cari akun';
  String notFoundText = 'Akun tidak ditemukan';
  List<String> items = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];

  void getAkunText(String? newValue) {
    setState(() {
      if (newValue != null) {
        textAkunController.text = newValue;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    tableRow = new BukuBesarTableData(
      contentData: contents,
      context: context,
    );
  }

  @override
  void dispose() {
    textAkunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Buku Besar',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: 25, bottom: 15, left: 25, right: 25),
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
                    margin: EdgeInsets.only(
                        top: 25, bottom: 15, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Buku Besar",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Color.fromARGB(255, 50, 52, 55)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "November 2022",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 50, 52, 55)),
                            ),
                          ],
                        ),
                        Visibility(
                          visible:
                              (textAkunController.text != '' ? true : false),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Kode Akun: ",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 50, 52, 55)),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "2.5-5101-10-01-01",
                                    style: TextStyle(
                                        fontFamily: "Inter",
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 50, 52, 55)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Akun, Debit",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 50, 52, 55)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                  color: background2,
                  child: DropdownSearchButton(
                    controller: textAkunController,
                    hintText: 'Cari akun',
                    notFoundText: 'Akun tidak ditemukan',
                    items: items,
                    onChange: getAkunText,
                    isNeedChangeColor:
                        (textAkunController.text != '' ? true : false),
                    colorWhenChanged: Color(int.parse(yellowTextColor)),
                  ),
                ),
                Visibility(
                  visible: (textAkunController.text != '' ? true : false),
                  child: Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Total Saldo: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                    )),
                                Text('Rp 500.000',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                    )),
                              ],
                            ),
                            ActionButton(
                                textContent: 'Cetak Buku Besar',
                                onPressed: () {
                                  //
                                })
                          ],
                        ),
                        PaginatedDataTable(
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                color: Color(int.parse(greyHeaderColor)),
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Tanggal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              )),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                color: Color(int.parse(greyHeaderColor)),
                                height: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  "Nama Transaksi",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              )),
                            ),
                            DataColumn(
                                label: Expanded(
                                    child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "No. Bukti",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ))),
                            DataColumn(
                                label: Expanded(
                                    child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Keterangan",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ))),
                            DataColumn(
                                label: Expanded(
                                    child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "Saldo (Rp.)",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                              ),
                            ))),
                          ],
                          source: tableRow,
                          rowsPerPage: 5,
                          showCheckboxColumn: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
