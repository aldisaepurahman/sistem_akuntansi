import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class JurnalUmumList extends StatefulWidget {
  const JurnalUmumList({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  JurnalUmumListState createState() {
    return JurnalUmumListState();
  }
}

class JurnalUmumListState extends State<JurnalUmumList> {
  // bool show = false;
  // bool disable_button = false;

  var tableRow;

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: contents,
      seeDetail: () {
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
              SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 1, bukuBesarIndex: 0, client: widget.client)));
        });
      },
      context: context,
    );
  }

  // void showForm() {
  //   setState(() {
  //     show = true;
  //     disable_button = true;
  //   });
  // }
  //
  // void disableForm() {
  //   setState(() {
  //     show = false;
  //     disable_button = false;
  //   });
  // }

  //Inisialisasi untuk Dropdown
  String _selectedMonthFilter = 'Januari';
  String _selectedYearFilter = '2022';

  String _selectedMonthInsert = 'Januari';
  String _selectedYearInsert = '2022';

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
            // Container(
            //   width: 30,
            //   margin: EdgeInsets.only(left: 25, top: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: kuning,
            //           padding: const EdgeInsets.all(18)),
            //         onPressed: showForm,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               children: [
            //                 Icon(
            //                   Icons.add,
            //                   size: 13,
            //                   color: hitam,
            //                 ),
            //                 const SizedBox(
            //                   width: 10,
            //                 ),
            //                 Text(
            //                   "Tambah Jurnal",
            //                   style: TextStyle(
            //                     fontFamily: "Inter",
            //                     color: hitam,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ],
            //         )
            //       )
            //     ],
            //   )
            // ),
            // Visibility(
            //   visible: show,
            //   child: Container(
            //     margin: EdgeInsets.all(25),
            //     padding: EdgeInsets.all(25),
            //     color: background2,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           margin: EdgeInsets.only(bottom: 20),
            //           child: HeaderText(
            //               content: "Tambah Jurnal Umum",
            //               size: 18,
            //               color: hitam),
            //         ),
            //         Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               SizedBox(
            //                 width: MediaQuery.of(context).size.width * 0.25,
            //                 child: DropdownForm(
            //                     onChanged: (String? newValue) {
            //                       setState(() {
            //                         _selectedMonthInsert = newValue!;
            //                       });
            //                     },
            //                     content: _selectedMonthInsert,
            //                     items: month,
            //                     label: "--Pilih Bulan--"),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               SizedBox(
            //                   width: MediaQuery.of(context).size.width *
            //                       0.25,
            //                   child: DropdownForm(
            //                       onChanged: (String? newValue) {
            //                         setState(() {
            //                           _selectedYearInsert = newValue!;
            //                         });
            //                       },
            //                       content: _selectedYearInsert,
            //                       items: year,
            //                       label: "--Pilih Tahun--")),
            //             ]),
            //         SizedBox(
            //           height: 30,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             ButtonNoIcon(
            //                 bg_color: background2,
            //                 text_color: merah,
            //                 onPressed: disableForm,
            //                 content: "Batal"),
            //             SizedBox(width: 20),
            //             ButtonNoIcon(
            //                 bg_color: kuning,
            //                 text_color: hitam,
            //                 onPressed: () {
            //                   setState(() {});
            //                 },
            //                 content: "Simpan")
            //           ],
            //         )
            //       ],
            //     ),
            //   )
            // ),
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
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
                              _selectedMonthFilter = newValue;
                            }
                          });
                        },
                        content: _selectedMonthFilter,
                        items: month,
                      ),
                      SizedBox(width: 20),
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
                    ],
                  ),
                  SizedBox(height: 25),
                  PaginatedDataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text("No."),
                      ),
                      DataColumn(
                        label: Text("Bulan"),
                      ),
                      DataColumn(
                        label: Text("Tahun"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],
                    source: tableRow,
                    rowsPerPage: 10,
                    showCheckboxColumn: false,
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
