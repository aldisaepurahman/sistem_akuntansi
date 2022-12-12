import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ListBukuBesar extends StatefulWidget {
  const ListBukuBesar({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  ListBukuBesarState createState() {
    return ListBukuBesarState();
  }
}

class ListBukuBesarState extends State<ListBukuBesar> {
  // @override
  // void dispose() {}

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
  List<String> year = ['2022', '2023'];

  var tableRow;

  void _navigateToBukuBesarPerAkun(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 3,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 1,
          labaRugiIndex: 0,
          neracaLajurIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: contents,
      seeDetail: () {
        _navigateToBukuBesarPerAkun(context);
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Buku Besar',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 249, 253),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, left: 25),
              child: Text(
                "Buku Besar",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color.fromARGB(255, 50, 52, 55)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              padding: EdgeInsets.all(25),
              color: Color.fromARGB(255, 255, 255, 255),
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
                      dataRowHeight: 70,
                      columnSpacing: 0,
                      horizontalMargin: 0,
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
                    ),
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