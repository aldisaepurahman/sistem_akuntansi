import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/Buku_besar.dart';

class ListBukuBesarPerBulan extends StatefulWidget {
  const ListBukuBesarPerBulan({Key? key}) : super(key: key);

  @override
  ListBukuBesarPerBulanState createState() {
    return ListBukuBesarPerBulanState();
  }
}

class ListBukuBesarPerBulanState extends State<ListBukuBesarPerBulan> {
  var tableRow;

  @override
  void initState() {
    super.initState();
    tableRow = new BukuBesarTableData(
      contentData: contents,
      context: context,
    );
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
                  margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonBack(
                        onPressed: (){
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Buku Besar",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color.fromARGB(255, 50, 52, 55)
                        ),
                      ),
                      Text(
                        "Buku Besar",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color.fromARGB(255, 50, 52, 55)
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaginatedDataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text("Tanggal"),),
                          DataColumn(label: Text("Nama Transaksi"),),
                          DataColumn(label: Text("No. Bukti"),),
                          DataColumn(label: Text("Keterangan"),),
                          DataColumn(label: Text("Saldo (Rp.)"),),
                        ],
                        source: tableRow,
                        rowsPerPage: 5,
                        showCheckboxColumn: false,
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}


