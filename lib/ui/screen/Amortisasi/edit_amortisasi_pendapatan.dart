import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/AmortisasiPendapatan.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class EditAmortisasiPendapatan extends StatefulWidget {
  const EditAmortisasiPendapatan({required this.client, Key? key})
      : super(key: key);

  final SupabaseClient client;

  @override
  EditAmortisasiPendapatanState createState() {
    return EditAmortisasiPendapatanState();
  }
}

class EditAmortisasiPendapatanState extends State<EditAmortisasiPendapatan> {
  @override
  void dispose() {}

  //Inisialisasi untuk Dropdown
  TextEditingController keterangan = TextEditingController();
  TextEditingController total_harga = TextEditingController();
  TextEditingController jumlah_mahasiswa = TextEditingController();

  String _selectedSemesterInsert = 'Ganjil';
  String _selectedAkunInsert = '2022';

  List<String> semester = ['Ganjil', 'Genap'];
  List<String> akun = ['2021', '2022', '2023', '2024', '2025'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Amortisasi Pendapatan',
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
                        content: "Amortisasi Pendapatan",
                        size: 32,
                        color: hitam)),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(25),
                  color: background2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: HeaderText(
                            content: "Edit Amortisasi Pendapatan",
                            size: 18,
                            color: hitam),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextForm(
                                    hintText: "Masukkan keterangan...",
                                    textController: keterangan)),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextForm(
                                    hintText: "Masukkan total harga...",
                                    textController: total_harga)),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: DropdownForm(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedSemesterInsert = newValue!;
                                    });
                                  },
                                  content: _selectedSemesterInsert,
                                  items: semester,
                                  label: "Pilih Semester"),
                            )
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: TextForm(
                                    hintText: "Masukkan jumlah mahasiswa...",
                                    textController: jumlah_mahasiswa)),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 3),
                                  child: DropdownForm(
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedAkunInsert = newValue!;
                                        });
                                      },
                                      content: _selectedAkunInsert,
                                      items: akun,
                                      label: "Pilih Akun"),
                                ))
                          ]),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonNoIcon(
                              bg_color: background2,
                              text_color: merah,
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
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SideNavigationBar(
                                                              index: 1,
                                                              coaIndex: 2,
                                                              jurnalUmumIndex:
                                                                  0,
                                                              bukuBesarIndex: 0,
                                                              client: widget
                                                                  .client)));
                                            });
                                          });
                                    });
                              },
                              content: "Batal"),
                          SizedBox(width: 20),
                          ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return DialogNoButton(
                                          content: "Berhasil Ditambahkan!",
                                          content_detail:
                                              "Amortisasi Pendapatan berhasil diedit ditambahkan",
                                          path_image:
                                              'assets/images/tambah_coa.png');
                                    });
                              },
                              content: "Simpan")
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
