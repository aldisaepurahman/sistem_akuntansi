import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class EditAmortisasiAset extends StatefulWidget {
  const EditAmortisasiAset({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  EditAmortisasiAsetState createState() {
    return EditAmortisasiAsetState();
  }
}

class EditAmortisasiAsetState extends State<EditAmortisasiAset> {
  @override
  void dispose() {}

  DateTime? _saat_perolehan;
  //Inisialisasi untuk Dropdown
  TextEditingController keterangan = TextEditingController();
  TextEditingController nilai_perolehan = TextEditingController();
  TextEditingController masa_guna = TextEditingController();
  TextEditingController akumulasi_penyusutan_tahun_lalu =
      TextEditingController();
  TextEditingController saat_perolehan = TextEditingController();
  TextEditingController akun = TextEditingController();

  String _selectedAkunFilter = 'Beban Kesekretariatan';
  String _selectedYearFilter = '2022';
  String _selectedEntryFilter = '5';

  String _selectedAkunInsert = 'Beban Kesekretariatan';
  String _selectedYearInsert = '2022';

  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];
  List<String> year = ['2021', '2022', '2023', '2024', '2025'];
  List<String> entry = ['5', '10', '25', '50', '100'];

  void initState() {
    super.initState();
    _saat_perolehan = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Amortisasi Aset',
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
                        content: "Amortisasi Aset", size: 32, color: hitam)),
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
                            content: "Edit Amortisasi Aset",
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
                                    hintText: "Masukkan masa guna...",
                                    textController: masa_guna)),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: TextForm(
                                  hintText: "Masukkan nilai perolehan...",
                                  textController: nilai_perolehan,
                                  label: "Rp"),
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
                                  hintText: "Masukkan penyusutan tahun lalu...",
                                  textController:
                                      akumulasi_penyusutan_tahun_lalu,
                                  label: "Rp",
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: DropdownSearchButton(
                                    controller: akun,
                                    hintText: "Masukkan Akun Amortisasi...",
                                    notFoundText: 'Akun tidak ditemukan',
                                    items: namaAkunList,
                                    onChange: (String? new_value) {},
                                    isNeedChangeColor: false)),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 3),
                                    child: TextField(
                                      controller: saat_perolehan,
                                      style: TextStyle(fontSize: 13),
                                      readOnly: true,
                                      onTap: () async {
                                        showMonthPicker(
                                                unselectedMonthTextColor: hitam,
                                                headerColor: kuning,
                                                headerTextColor: hitam,
                                                selectedMonthBackgroundColor:
                                                    kuning,
                                                selectedMonthTextColor: hitam,
                                                context: context,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                                initialDate: DateTime.now())
                                            .then((date) {
                                          if (date != null) {
                                            setState(() {
                                              _saat_perolehan = date;
                                            });
                                          }
                                        });
                                        String formattedDate = DateFormat()
                                            .add_yM()
                                            .format(_saat_perolehan!);
                                        saat_perolehan.text = formattedDate;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Masukkan saat perolehan",
                                          prefixIcon:
                                              Icon(Icons.calendar_today),
                                          contentPadding:
                                              const EdgeInsets.all(5),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                    )))
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
