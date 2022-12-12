import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class JurnalPenyesuaianList extends StatefulWidget {
  const JurnalPenyesuaianList({required this.client, Key? key})
  : super(key: key);

  final SupabaseClient client;

  @override
  JurnalPenyesuaianListState createState() {
    return JurnalPenyesuaianListState();
  }
}

class JurnalPenyesuaianListState extends State<JurnalPenyesuaianList> {
  @override
  void dispose() {}

  bool show = false;
  bool disable_button = false;

  var tableRow;

  void _navigateToJenisJurnal(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 7,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          labaRugiIndex: 0,
          neracaLajurIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 1,
          client: widget.client
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: const <VBulanJurnal>[],
      seeDetail: () {
        _navigateToJenisJurnal(context);
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
                      content: "Jurnal Penyesuaian", size: 32, color: hitam
                  )
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
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
                      Container(
                        width: double.infinity,
                        child: PaginatedDataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                    color: greyHeaderColor,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                    color: greyHeaderColor,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Bulan",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                    color: greyHeaderColor,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Tahun",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                  child: Container(
                                    color: greyHeaderColor,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Action",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                          source: tableRow,
                          rowsPerPage: 10,
                          showCheckboxColumn: false,
                          columnSpacing: 0,
                          horizontalMargin: 0,
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