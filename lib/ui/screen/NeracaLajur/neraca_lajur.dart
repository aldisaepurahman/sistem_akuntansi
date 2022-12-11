import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class NeracaLajurList extends StatefulWidget {
  final SupabaseClient client;

  const NeracaLajurList({required this.client, Key? key}) : super(key: key);

  @override
  NeracaLajurListState createState() {
    return NeracaLajurListState();
  }
}

class NeracaLajurListState extends State<NeracaLajurList> {
  @override
  void dispose() {}

  bool show = false;
  bool disable_button = false;

  var tableRow;

  void _navigateToLaporanNeracaLajur(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SideNavigationBar(
          index: 4,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          neracaLajurIndex: 1,
          labaRugiIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
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
        _navigateToLaporanNeracaLajur(context);
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
        title: 'List Neraca Lajur',
        home: Scaffold(
            backgroundColor: background,
            body: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25, left: 25),
                    child: HeaderText(
                        content: "Neraca Lajur", size: 32, color: hitam)),
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
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
