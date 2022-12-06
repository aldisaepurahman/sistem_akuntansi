import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:intl/intl.dart';

class TransaksiList extends StatefulWidget {
  const TransaksiList({Key? key}) : super(key: key);

  @override
  TransaksiListState createState() {
    return TransaksiListState();
  }
}

class TransaksiListState extends State<TransaksiList> {
  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  bool show = false;
  bool disable_button = false;

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

  @override
  void initState() {
    input.text = ""; //set the initial value of text field
    super.initState();
  }

  //Inisialisasi untuk Dropdown
  String _selectedMonthFilter = 'Januari';
  String _selectedYearFilter = '2022';

  String _selectedMonthInsert = 'Januari';
  String _selectedYearInsert = '2022';

  String _selectedJurnalInsert = "JURNAL PENGELUARAN KAS";
  String _selectedJurnalFilter = "JURNAL PENGELUARAN KAS";

  List<String> month = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  List<String> year = ['2021', '2022', '2023', '2024', '2025'];
  List<String> entry = ['5', '10', '25', '50', '100'];
  List<String> jurnal = [
    "JURNAL PENGELUARAN KAS",
    "JURNAL PENERIMAAN KAS",
    "JURNAL PENGELUARAN BANK OCBC NISP",
    "JURNAL PENERIMAAN BANK OCBC NISP",
    "JURNAL PENGELUARAN BRI STIKES SANTO BORROMEUS",
    "JURNAL PENERIMAAN BRI STIKES SANTO BORROMEUS",
    "JURNAL PENGELUARAN TABUNGAN BRITAMA",
    "JURNAL PENERIMAAN TABUNGAN BRITAMA",
    "JURNAL PENGELUARAN BRI BRIVA",
    "JURNAL PENERIMAAN BRI BRIVA",
    "JURNAL TABUNGAN BNI",
    "JURNAL GAJI"
  ];

  final TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Transaksi',
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
                        content: "Daftar Transaksi", size: 32, color: hitam)),
                Container(
                    margin: EdgeInsets.only(bottom: 15, left: 25),
                    child: HeaderText(
                        content: "Jurnal Maret 2022", size: 18, color: hitam)),
                Container(
                    width: 30,
                    margin: EdgeInsets.only(left: 25, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kuning,
                                padding: const EdgeInsets.all(18)),
                            onPressed: disable_button ? null : showForm,
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
                                      "Tambah Transaksi",
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
                            margin: EdgeInsets.only(bottom: 15),
                            child: HeaderText(
                                content: "Tambah Transaksi",
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 20),
                                      child: TextField(
                                        controller: input,
                                        style: TextStyle(fontSize: 13),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100));

                                          if (date != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            setState(() {
                                              input.text = formattedDate;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText:
                                                "Masukkan tanggal transaksi",
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            contentPadding:
                                                const EdgeInsets.all(5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: TextForm(
                                        hintText: "Masukkan nama transaksi")),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: DropdownForm(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedJurnalInsert = newValue!;
                                          });
                                        },
                                        content: _selectedJurnalInsert,
                                        items: jurnal)),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: TextForm(
                                        hintText: "Masukkan no bukti")),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: abu_transparan))),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: HeaderText(
                                            content: "Debit",
                                            size: 16,
                                            color: hitam),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: TextForm(hintText: "Jumlah"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: ButtonAdd(onPressed: () {
                                              setState(() {});
                                            }),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: abu_transparan))),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: HeaderText(
                                            content: "Kredit",
                                            size: 16,
                                            color: hitam),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: TextForm(hintText: "Jumlah"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: ButtonAdd(onPressed: () {
                                              setState(() {});
                                            }),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                                    setState(() {});
                                  },
                                  content: "Simpan")
                            ],
                          )
                        ],
                      ),
                    )),

                // Container(
                //   margin: EdgeInsets.all(25),
                //   padding: EdgeInsets.all(25),
                //   color: background2,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       DataTable(
                //         border: TableBorder(
                //             bottom: BorderSide(
                //                 color: Color.fromARGB(50, 117, 117, 117),
                //                 width: 1)),
                //         columns: [
                //           TableRow(
                //               decoration: BoxDecoration(
                //                   color: Color.fromARGB(255, 245, 245, 245)),
                //               children: [
                //                 HeaderTable(content: "No"),
                //                 HeaderTable(content: "Bulan"),
                //                 HeaderTable(content: "Tahun"),
                //                 HeaderTable(content: "Aksi")
                //               ]),
                //           TableRow(children: [
                //             RowContent(content: "1"),
                //             RowContent(content: kode_akun),
                //             RowContent(content: nama_akun),
                //             RowContent(content: keterangan),
                //             RowContent(content: kode_reference),
                //             ActionButton()
                //           ])
                //         ],
                //       )
                //     ],
                //   ),
                // )
              ],
            )));
  }
}
