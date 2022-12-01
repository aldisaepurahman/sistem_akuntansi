import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';

class DetailCOA extends StatefulWidget {
  const DetailCOA({Key? key}) : super(key: key);

  @override
  DetailCOAState createState() {
    return DetailCOAState();
  }
}

class DetailCOAState extends State<DetailCOA> {
  @override
  void dispose() {}

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
        title: 'Detail Chart of Account',
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
                      Container(
                          child: const Text(
                        "Detail CoA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 204, 0)),
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailText(header: "Kode", content: kode_akun),
                              DetailText(
                                  header: "Keterangan", content: keterangan),
                              DetailText(
                                  header: "Saldo Awal", content: saldo_awal)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailText(
                                  header: "Nama Akun", content: nama_akun),
                              DetailText(
                                  header: "Kode Reference",
                                  content: kode_reference),
                              DetailText(
                                  header: "Saldo Awal Baru",
                                  content: saldo_awal_baru)
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40, bottom: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 204, 0),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Color.fromARGB(255, 50, 52, 55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text(
                            "Hapus",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Color.fromARGB(255, 245, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
