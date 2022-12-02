import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';

class JurnalUmumList extends StatefulWidget {
  const JurnalUmumList({Key? key}) : super(key: key);

  @override
  JurnalUmumListState createState() {
    return JurnalUmumListState();
  }
}

class JurnalUmumListState extends State<JurnalUmumList> {
  @override
  void dispose() {}

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

  //Inisialisasi untuk Dropdown
  String value_bulan = "Januari";
  String value_tahun = "2025";

  List<DropdownMenuItem<String>> get dropdownBulan {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Januari"), value: "Januari"),
      DropdownMenuItem(child: Text("Februari"), value: "Februari"),
      DropdownMenuItem(child: Text("Maret"), value: "Maret"),
      DropdownMenuItem(child: Text("April"), value: "April"),
      DropdownMenuItem(child: Text("Mei"), value: "Mei"),
      DropdownMenuItem(child: Text("Juni"), value: "Juni"),
      DropdownMenuItem(child: Text("Juli"), value: "Juli"),
      DropdownMenuItem(child: Text("Agustus"), value: "Agustus"),
      DropdownMenuItem(child: Text("September"), value: "September"),
      DropdownMenuItem(child: Text("Oktober"), value: "Oktober"),
      DropdownMenuItem(child: Text("November"), value: "November"),
      DropdownMenuItem(child: Text("Desember"), value: "Desember"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownTahun {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("2025"), value: "2025"),
      DropdownMenuItem(child: Text("2024"), value: "2024"),
      DropdownMenuItem(child: Text("2023"), value: "2023"),
      DropdownMenuItem(child: Text("2022"), value: "2022"),
      DropdownMenuItem(child: Text("2021"), value: "2021"),
      DropdownMenuItem(child: Text("2020"), value: "2020"),
    ];
    return menuItems2;
  }

  //Table
  final List<Map<String, String>> listOfColumns = [
    {
      "Name": "AAAAAA",
      "Number": "1",
      "State": "Yes",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Jurnal Umum',
        home: Scaffold(
            backgroundColor: background,
            body: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25),
                    child: HeaderText(
                        content: "Jurnal Umum", size: 32, color: hitam)),
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
                                      "Tambah Jurnal",
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
                                content: "Tambah Jurnal Umum",
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: DropdownForm(
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          value_bulan = newValue!;
                                        });
                                      },
                                      content: value_bulan,
                                      items: dropdownBulan,
                                      label: "--Pilih Bulan--"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: DropdownForm(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            value_tahun = newValue!;
                                          });
                                        },
                                        content: value_tahun,
                                        items: dropdownTahun,
                                        label: "--Pilih Tahun--")),
                              ]),
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
