import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/navigationBar.dart';

class LabaRugiList extends StatefulWidget {
  const LabaRugiList({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  LabaRugiListState createState() {
    return LabaRugiListState();
  }
}

class LabaRugiListState extends State<LabaRugiList> {
  @override
  void dispose() {
    super.dispose();
  }

  bool show = false;
  bool disable_button = false;

  var tableRow;

  void _navigateToLaporanLabaRugi(BuildContext context, int bulan, int tahun){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
        SideNavigationBar(
          index: 5,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          neracaLajurIndex: 0,
          labaRugiIndex: 1,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
          params: {"bulan": listbulan[bulan], "tahun": tahun},
        )
      )
    );
  }

  var list_bulan = <VBulanJurnal>[];
  late VBulanJurnalBloc _bulanBloc;

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: const <VBulanJurnal>[],
      seeDetail: (int index) {
        _navigateToLaporanLabaRugi(context, 0, 0);
      },
      context: context,
    );
    _bulanBloc = VBulanJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(BulanFetched());
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

  Map<int, String> listbulan = {
    1: "Januari",
    2: "Februari",
    3: "Maret",
    4: "April",
    5: "Mei",
    6: "Juni",
    7: "Juli",
    8: "Agustus",
    9: "September",
    10: "Oktober",
    11: "November",
    12: "Desember"
  };

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
        title: 'List Laba Rugi',
        home: Scaffold(
            backgroundColor: background,
            body: BlocProvider<VBulanJurnalBloc>(
              create: (context) => _bulanBloc,
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Laba Rugi", size: 32, color: hitam)),
                  Container(
                    margin:
                    EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Row(
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
                        ),*/
                        SizedBox(height: 25),
                        BlocConsumer<VBulanJurnalBloc, SiakState>(
                          builder: (_, state) {
                            if (state is LoadingState) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (state is FailureState) {
                              return Center(child: Text(state.error));
                            }
                            if (state is SuccessState) {
                              return Container(
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
                                  source: BulanTahunTableData(
                                    contentData: list_bulan,
                                    seeDetail: (int index) {
                                      _navigateToLaporanLabaRugi(context, list_bulan[index].bulan, list_bulan[index].tahun);
                                    },
                                    context: context,
                                  ),
                                  rowsPerPage: 5,
                                  showCheckboxColumn: false,
                                  columnSpacing: 0,
                                  horizontalMargin: 0,
                                  dataRowHeight: 50,
                                ),
                              );
                            }
                            return const Center(child: Text("No data"));
                          },
                          listener: (_, state) {
                            if (state is SuccessState) {
                              list_bulan.clear();
                              list_bulan = state.datastore;
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
