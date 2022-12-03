import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class ListCOA extends StatefulWidget {
  const ListCOA({Key? key}) : super(key: key);

  @override
  ListCOAState createState() {
    return ListCOAState();
  }
}

class ListCOAState extends State<ListCOA> {
  @override
  // void dispose() {}

  String kode_akun = "1.1-1104-01-02-01-05-05";
  String nama_akun =
      "Penyisihan Piutang Mahasiswa angkatan 2016/2017 D3 Perekam & Inf. Kes";
  String keterangan = "Akun, Debit";
  String kode_reference = "2";
  String saldo_awal = "-";
  String saldo_awal_baru = "Rp 29.702.072";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Chart of Account',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                  child: const Text(
                    "Chart of Account",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 50, 52, 55)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 204, 0),
                                    padding: EdgeInsets.all(20)),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SideNavigationBar(index: 1, coaIndex: 1)));
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          size: 13,
                                          color:
                                              Color.fromARGB(255, 50, 52, 55),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Tambah Chart of Account",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            color:
                                                Color.fromARGB(255, 50, 52, 55),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.19,
                            child: TextField(
                              decoration: InputDecoration(
                                  fillColor: Color.fromARGB(255, 117, 117, 117),
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor:
                                      Color.fromARGB(255, 117, 117, 117),
                                  hintText: 'Cari Chart of Account',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Table(
                        border: TableBorder(
                            bottom: BorderSide(
                                color: Color.fromARGB(50, 117, 117, 117),
                                width: 1)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245)),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("No",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Kode",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Nama Akun",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Keterangan",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("Indentasi",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(""),
                                ),
                              ]),
                          TableRow(children: [
                            RowContent(content: "1"),
                            RowContent(content: kode_akun),
                            RowContent(content: nama_akun),
                            RowContent(content: keterangan),
                            RowContent(content: kode_reference),
                            ActionButton(
                              textContent: 'Lihat Detail',
                              onPressed: (){
                                setState(() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SideNavigationBar(index: 1, coaIndex: 2)));
                                });
                              }
                            )
                          ])
                        ],
                      ),
                      SizedBox(height: 25),
                      Text("1 dari 1")
                    ],
                  ),
                )
              ],
            )));
  }
}
