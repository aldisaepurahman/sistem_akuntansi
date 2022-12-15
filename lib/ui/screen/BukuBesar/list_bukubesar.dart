import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
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

  var list_bulan = <VBulanJurnal>[];
  late VBulanJurnalBloc _bulanBloc;

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

  void _navigateToBukuBesarPerAkun(BuildContext context, int bulan, int tahun){
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
          client: widget.client,
          params: {"bulan": bulan, "tahun": tahun, "kode_akun": ""},
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: const <VBulanJurnal>[],
      seeDetail: (int index) {
        _navigateToBukuBesarPerAkun(context, 0, 0);
      },
      context: context,
    );

    _bulanBloc = VBulanJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(BulanFetched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Buku Besar',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 249, 253),
        body: BlocProvider<VBulanJurnalBloc>(
          create: (context) => _bulanBloc,
          child: ListView(
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
                                source: BulanTahunTableData(
                                  contentData: list_bulan,
                                  seeDetail: (int index) {
                                    _navigateToBukuBesarPerAkun(context, list_bulan[index].bulan, list_bulan[index].tahun);
                                  },
                                  context: context,
                                ),
                                rowsPerPage: 5,
                                showCheckboxColumn: false,
                              ),
                            );
                          }
                          return const SizedBox(width: 100);
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
        )
      )
    );
  }
}