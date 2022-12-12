import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailAmortisasiAset extends StatefulWidget {
  final SupabaseClient client;

  const DetailAmortisasiAset({required this.client, Key? key})
      : super(key: key);

  @override
  DetailAmortisasiAsetState createState() {
    return DetailAmortisasiAsetState();
  }
}

class DetailAmortisasiAsetState extends State<DetailAmortisasiAset> {
  void _navigateToAset(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 0,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToEditAset(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 2,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  @override
  void dispose() {}

  String keterangan = "NEBULIZER ULTRASONIC - HIBAH PHP PTS 2013";
  String saat_perolehan = "Desember'13";
  String masa_guna = "4";
  String akun = "Peralatan Laboratorium";
  String penyusutan = "229.167";
  String akumulasi_penyusutan_tahun_lalu = "11.000.000";
  String nilai_perolehan = "11.000.000";

  TextEditingController persentase = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Detail Amortisasi Aset',
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
                    child: HeaderText(
                        content: "Amortisasi Aset", size: 32, color: hitam)),
                Container(
                    width: 30,
                    margin: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kuning,
                                padding: const EdgeInsets.all(18)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogPenyusutan(
                                        penyusutan: penyusutan,
                                        persentase: persentase,
                                        onPressed: () {});
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 13,
                                      color: hitam,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Tambah Penyusutan Bulan Ini",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        color: hitam,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 25, bottom: 80, top: 25),
                  padding: EdgeInsets.all(25),
                  color: background2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: HeaderText(
                              content: "Detail Amortisasi Aset",
                              size: 24,
                              color: kuning)),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4 - 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailText(header: "Akun", content: akun),
                                DetailText(
                                    header: "Keterangan", content: keterangan),
                                DetailText(
                                    header: "Nilai Perolehan",
                                    content: "Rp" + nilai_perolehan),
                                DetailText(
                                    header: "Akumulasi Penyusutan Tahun Lalu",
                                    content:
                                        "Rp" + akumulasi_penyusutan_tahun_lalu)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4 - 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailText(
                                    header: "Masa Guna", content: masa_guna),
                                DetailText(
                                    header: "Saat Perolehan",
                                    content: saat_perolehan),
                                DetailText(
                                    header: "Penyusutan",
                                    content: "Rp " + penyusutan)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40, bottom: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kuning,
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            setState(() {
                              _navigateToEditAset(context);
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
                                      content: "Hapus Amortisasi Aset",
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
                                          _navigateToAset(context);
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
