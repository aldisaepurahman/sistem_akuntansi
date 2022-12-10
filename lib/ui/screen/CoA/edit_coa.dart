import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditCOA extends StatefulWidget {
  final SupabaseClient client;

  const EditCOA({required this.client, Key? key}) : super(key: key);

  @override
  EditCOAState createState() {
    return EditCOAState();
  }
}

class EditCOAState extends State<EditCOA> {
  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Chart of Account',
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
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SideNavigationBar(index: 1, coaIndex: 2, jurnalUmumIndex: 0, bukuBesarIndex: 0, client: widget.client)));
                            });
                          },
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 25),
                  child: Text(
                    "Edit Chart of Account",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 50, 52, 55)),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 60, right: 25, left: 25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Informasi CoA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 204, 0)),
                      )),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Nama Akun",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Masukkan nama akun...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan kode...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Keterangan',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan keterangan...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Indentasi',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan indentasi...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Saldo Awal (Opsional)",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Rp',
                              hintText: 'Masukkan saldo awal...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 204, 0),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return DialogNoButton(
                                      content: "Berhasil Diedit!",
                                      content_detail:
                                          "Chart of Account berhasil diedit",
                                      path_image:
                                          'assets/images/tambah_coa.png');
                                });
                          },
                          child: Text(
                            "Simpan",
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
                                  content: "Batalkan Perubahan",
                                  content_detail:
                                      "Anda yakin ingin membatalkan perubahan ini?",
                                  path_image:
                                      'assets/images/berhasil_hapus_coa.png',
                                  button1: "Tetap Simpan",
                                  button2: "Ya, Hapus",
                                  onPressed1: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  onPressed2: () {
                                    setState(() {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                          SideNavigationBar(index: 1, coaIndex: 2, jurnalUmumIndex: 0, bukuBesarIndex: 0, client: widget.client)));
                                    });
                                  }
                                );
                              }
                            );
                          },
                          child: Text(
                            "Batalkan",
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
            )
        )
    );
  }
}
