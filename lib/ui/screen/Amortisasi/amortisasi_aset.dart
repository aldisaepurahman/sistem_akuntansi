import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/AmortisasiAset.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class AmortisasiAsetList extends StatefulWidget {
  const AmortisasiAsetList({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  AmortisasiAsetListState createState() {
    return AmortisasiAsetListState();
  }
}

class AmortisasiAsetListState extends State<AmortisasiAsetList> {
  @override
  void dispose() {}

  DateTime? _saat_perolehan;

  bool show = false;
  bool disable_button = false;

  var tableRow;

  void _navigateToDetailAset(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 1,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToPendapatan(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 3,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToTambahAkun(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 6,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  @override
  void initState() {
    super.initState();
    _saat_perolehan = DateTime.now();
    tableRow = new AmortisasiAsetTable(
      contentData: content,
      seeDetail: () {
        setState(() {
          _navigateToDetailAset(context);
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Amortisasi Aset',
        home: Scaffold(
            backgroundColor: background,
            body: ListView(
              children: [
                /*Container(
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
                    )),*/
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25),
                    child: HeaderText(
                        content: "Amortisasi Aset", size: 32, color: hitam)),
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
                            )),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kuning,
                                padding: const EdgeInsets.all(18)),
                            onPressed: () {
                              setState(() {
                                _navigateToPendapatan(context);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.list_alt_rounded,
                                      size: 13,
                                      color: hitam,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Amortisasi Pendapatan",
                                      style: TextStyle(
                                        fontFamily: "Inter",
                                        color: hitam,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kuning,
                                padding: const EdgeInsets.all(18)),
                            onPressed: () {
                              setState(() {
                                _navigateToTambahAkun(context);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.list_alt_rounded,
                                      size: 13,
                                      color: hitam,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Akun Amortisasi",
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
                                content: "Tambah Amortisasi Aset",
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: TextForm(
                                        hintText: "Masukkan keterangan...",
                                        textController: keterangan)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: TextForm(
                                        hintText: "Masukkan masa guna...",
                                        textController: masa_guna)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: TextForm(
                                      hintText:
                                          "Masukkan penyusutan tahun lalu...",
                                      textController:
                                          akumulasi_penyusutan_tahun_lalu,
                                      label: "Rp",
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: TextField(
                                          controller: saat_perolehan,
                                          style: TextStyle(fontSize: 13),
                                          readOnly: true,
                                          onTap: () {
                                            showMonthPicker(
                                                    unselectedMonthTextColor:
                                                        hitam,
                                                    headerColor: kuning,
                                                    headerTextColor: hitam,
                                                    selectedMonthBackgroundColor:
                                                        kuning,
                                                    selectedMonthTextColor:
                                                        hitam,
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
                                              hintText:
                                                  "Masukkan saat perolehan",
                                              prefixIcon:
                                                  Icon(Icons.calendar_today),
                                              contentPadding:
                                                  const EdgeInsets.all(5),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
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
                                                  "Amortisasi Aset baru berhasil ditambahkan",
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
                                  _selectedYearFilter = newValue;
                                }
                              });
                            },
                            content: _selectedYearFilter,
                            items: year,
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
                            items: namaAkunList,
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
                                "No",
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
                                "Saat Perolehan",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Masa Guna",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Nilai Perolehan",
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
                          dataRowHeight: 70,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
