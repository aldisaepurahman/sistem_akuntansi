import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailCOA extends StatefulWidget {
  final SupabaseClient client;

  const DetailCOA({required this.client, Key? key}) : super(key: key);

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
  String indentasi = "2";
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
                  color: background2,
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
                                  header: "Indentasi", content: indentasi),
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
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SideNavigationBar(
                                      index: 1,
                                      coaIndex: 3,
                                      jurnalUmumIndex: 0,
                                      bukuBesarIndex: 0,
                                      client: widget.client)));
                            });
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog2Button(
                                      content: "Hapus Chart of Account",
                                      content_detail:
                                          "Anda yakin ingin menghapus data ini?",
                                      path_image: 'assets/images/hapus_coa.png',
                                      button1: "Tetap Simpan",
                                      button2: "Ya, Hapus",
                                      onPressed1: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      onPressed2: () {
                                        setState(() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SideNavigationBar(
                                                          index: 1,
                                                          coaIndex: 0,
                                                          jurnalUmumIndex: 0,
                                                          bukuBesarIndex: 0,
                                                          client:
                                                              widget.client)));
                                        });
                                      });
                                });
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
