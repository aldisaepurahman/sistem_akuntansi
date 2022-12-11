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

class AmortisasiPendapatanList extends StatefulWidget {
  const AmortisasiPendapatanList({required this.client, Key? key})
      : super(key: key);

  final SupabaseClient client;

  @override
  AmortisasiPendapatanListState createState() {
    return AmortisasiPendapatanListState();
  }
}

class AmortisasiPendapatanListState extends State<AmortisasiPendapatanList> {
  @override
  void dispose() {}

  bool show = false;
  bool disable_button = false;

  var tableRow;

  @override
  void initState() {
    super.initState();
    tableRow = new AmortisasiPendapatanTable(
      contentData: content,
      seeDetail: () {
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SideNavigationBar(
                  index: 3,
                  coaIndex: 0,
                  jurnalUmumIndex: 0,
                  bukuBesarIndex: 1,
                  client: widget.client)));
        });
      },
      context: context,
    );
  }

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;
    });
  }

  //Inisialisasi untuk Dropdown
  TextEditingController keterangan = TextEditingController();
  TextEditingController total_harga = TextEditingController();
  TextEditingController jumlah_mahasiswa = TextEditingController();

  String _selectedSemesterFilter = 'Ganjil';
  String _selectedAkunFilter = '2022';
  String _selectedEntryFilter = '5';

  String _selectedSemesterInsert = 'Ganjil';
  String _selectedAkunInsert = '2022';

  List<String> semester = ['Ganjil', 'Genap'];
  List<String> akun = ['2021', '2022', '2023', '2024', '2025'];
  List<String> entry = ['5', '10', '25', '50', '100'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Amortisasi Pendapatan',
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
                    width: 30,
                    margin: EdgeInsets.only(left: 25, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kuning,
                                padding: const EdgeInsets.all(18)),
                            onPressed: showForm,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "Tambah Amortisasi",
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
                Visibility(
                    visible: show,
                    child: Container(
                      margin: EdgeInsets.all(25),
                      padding: EdgeInsets.all(25),
                      color: background2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: HeaderText(
                                content: "Tambah Amortisasi Pendapatan",
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: TextForm(
                                        hintText: "Masukkan keterangan...",
                                        textController: keterangan)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: TextForm(
                                        hintText: "Masukkan total harga...",
                                        textController: total_harga)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: TextForm(
                                        hintText:
                                            "Masukkan jumlah mahasiswa...",
                                        textController: jumlah_mahasiswa)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
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
                                  onPressed: disableForm,
                                  content: "Batal"),
                              SizedBox(width: 20),
                              ButtonNoIcon(
                                  bg_color: kuning,
                                  text_color: hitam,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return DialogNoButton(
                                              content: "Berhasil Ditambahkan!",
                                              content_detail:
                                                  "Amortisasi Pendapatan baru berhasil ditambahkan",
                                              path_image:
                                                  'assets/images/tambah_coa.png');
                                        });
                                  },
                                  content: "Simpan")
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 80, right: 25, left: 25),
                  padding: EdgeInsets.all(25),
                  color: background2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DropdownFilter(
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _selectedSemesterFilter = newValue;
                                }
                              });
                            },
                            content: _selectedSemesterFilter,
                            items: semester,
                          ),
                          SizedBox(width: 20),
                          DropdownFilter(
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _selectedAkunFilter = newValue;
                                }
                              });
                            },
                            content: _selectedAkunFilter,
                            items: akun,
                          ),
                          SizedBox(width: 20),
                          DropdownFilter(
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _selectedEntryFilter = newValue;
                                }
                              });
                            },
                            content: _selectedEntryFilter,
                            items: entry,
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                        child: PaginatedDataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                "No.",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Keterangan",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Total",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Jumlah Mahasiswa",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Penyusutan",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Action",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          source: tableRow,
                          rowsPerPage: int.parse(_selectedEntryFilter),
                          showCheckboxColumn: false,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}