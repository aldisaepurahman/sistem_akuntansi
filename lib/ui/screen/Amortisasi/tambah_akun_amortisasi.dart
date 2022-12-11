import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/AkunAmortisasi.dart';
import 'package:sistem_akuntansi/utils/AmortisasiPendapatan.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class TambahAkunAmortisasiList extends StatefulWidget {
  const TambahAkunAmortisasiList({required this.client, Key? key})
      : super(key: key);

  final SupabaseClient client;

  @override
  TambahAkunAmortisasiListState createState() {
    return TambahAkunAmortisasiListState();
  }
}

class TambahAkunAmortisasiListState extends State<TambahAkunAmortisasiList> {
  @override
  void dispose() {}

  bool show = false;
  bool disable_button = false;

  var tableRow;

  TextEditingController akun = TextEditingController();

  String _selectedEntryFilter = '5';
  List<String> entry = ['5', '10', '25', '50', '100'];

  @override
  void initState() {
    super.initState();
    tableRow = new ListAmortisasiTable(
      contentData: content_akun,
      onPressed1: () {
        setState(() {}); //belum diset
      },
      onPressed2: () {
        setState(() {}); //belum diset
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

  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tambah Akun Amortisasi',
        home: Scaffold(
            backgroundColor: background,
            body: ListView(children: [
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
                      content: "Akun Amortisasi", size: 32, color: hitam)),
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
                                    "Tambah Akun Amortisasi",
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
                                content: "Tambah Akun Amortisasi",
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: DropdownSearchButton(
                                      controller: akun,
                                      hintText: "Masukkan Akun Amortisasi...",
                                      notFoundText: 'Akun tidak ditemukan',
                                      items: namaAkunList,
                                      onChange: (String? new_value) {},
                                      isNeedChangeColor: false)),
                            ],
                          ),
                          SizedBox(height: 30),
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
                      ))),
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
                              "Akun",
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
                        dataRowHeight: 60,
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
