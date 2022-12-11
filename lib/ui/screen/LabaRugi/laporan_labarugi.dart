import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class LaporanLabaRugi extends StatefulWidget {
  final SupabaseClient client;

  const LaporanLabaRugi({required this.client, Key? key}) : super(key: key);

  @override
  LaporanLabaRugiState createState() {
    return LaporanLabaRugiState();
  }
}

class LaporanLabaRugiState extends State<LaporanLabaRugi> {
  @override
  void dispose() {}

  bool show = false;
  bool disable_button = false;

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
              SideNavigationBar(
                index: 5,
                coaIndex: 0,
                jurnalUmumIndex: 0,
                bukuBesarIndex: 0,
                neracaLajurIndex: 0,
                labaRugiIndex: 0,
                amortisasiIndex: 0,
                jurnalPenyesuaianIndex: 0,
                client: widget.client,
              )
            )
          );
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
        title: 'Laporan Laba Rugi',
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
                        content: "Laporan Laba Rugi", size: 32, color: hitam)),
                Container(
                    margin: EdgeInsets.only(bottom: 15, left: 25),
                    child: HeaderText(
                        content: "Bulan Maret 2022", size: 18, color: hitam)),
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
                          ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: () {},
                              content: "Cetak Laporan")
                        ],
                      ),
                      SizedBox(height: 25),
                      // PaginatedDataTable(
                      //   columns: <DataColumn>[
                      //     DataColumn(
                      //       label: Text("No."),
                      //     ),
                      //     DataColumn(
                      //       label: Text("Bulan"),
                      //     ),
                      //     DataColumn(
                      //       label: Text("Tahun"),
                      //     ),
                      //     DataColumn(
                      //       label: Text("Action"),
                      //     ),
                      //   ],
                      //   source: tableRow,
                      //   rowsPerPage: 10,
                      //   showCheckboxColumn: false,
                      // )
                    ],
                  ),
                )
              ],
            )));
  }
}
