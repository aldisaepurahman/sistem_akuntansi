// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_cubit.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/utils/V_lookup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ListCOA extends StatefulWidget {
  const ListCOA({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  ListCOAState createState() {
    return ListCOAState();
  }
}

class ListCOAState extends State<ListCOA> {
  @override
  void dispose() {
    super.dispose();
  }

  String keyword = "";
  List<Akun> data_akun = [];
  var tableRow;
  
  int total_row = 5;

  String _selectedEntries = '5';

  List<String> row = ['5', '10', '25', '50', '100'];

  void _navigateToDetailCoa(BuildContext context, Map<String, dynamic> params) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SideNavigationBar(
          index: 1,
          coaIndex: 2,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          neracaLajurIndex: 0,
          labaRugiIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
          params: params
        )
      )
    );
  }

  void _navigateToTambahCoa(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SideNavigationBar(
          index: 1,
          coaIndex: 1,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          neracaLajurIndex: 0,
          labaRugiIndex: 0,
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
    tableRow = new RowTableCOA(
      contentData: const <Akun>[],
      seeDetail: (int index) {
        _navigateToDetailCoa(context, {"akun": ""});
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Chart of Account',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: BlocProvider<VLookupBloc>(
              create: (BuildContext context) => VLookupBloc(service: SupabaseService(supabaseClient: widget.client))..add(AkunFetched()),
              // create: (BuildContext context) => VLookupCubit(service: SupabaseService(supabaseClient: widget.client)),
              child: ListView(
                children: [
                Container(
                  margin: EdgeInsets.only(top: 25, left: 25),
                  child: const Text(
                    "Chart of Account",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 50, 52, 55)),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 50, left: 25, right: 25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.21,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 204, 0),
                                    padding: EdgeInsets.all(20)),
                                onPressed: () {
                                  _navigateToTambahCoa(context);
                                  /*setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SideNavigationBar(index: 1, coaIndex: 1, bukuBesarIndex: 0, client: widget.client)));
                                  });*/
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 50, 52, 55),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Tambah Chart of Account",
                                              style: TextStyle(
                                                fontFamily: "Inter",
                                                color: Color.fromARGB(
                                                    255, 50, 52, 55),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Tambah Chart of Account",
                                          style: TextStyle(
                                            fontFamily: "Inter",
                                            color:
                                                Color.fromARGB(255, 50, 52, 55),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          fillColor: Color.fromARGB(
                                              255, 117, 117, 117),
                                          prefixIcon: Icon(Icons.search),
                                          prefixIconColor: Color.fromARGB(
                                              255, 117, 117, 117),
                                          hintText: 'Cari Chart of Account',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      onChanged: (value) {
                                        VLookupBloc(
                                                service: SupabaseService(
                                                    supabaseClient:
                                                        widget.client))
                                            .add(AkunSearched(keyword: value));
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    child: DropdownFilter(
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          if (newValue != null) {
                                            total_row = int.parse(newValue);
                                            _selectedEntries = newValue;
                                          }
                                        });
                                      },
                                      content: _selectedEntries,
                                      items: row,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /*SizedBox(
                                width: MediaQuery.of(context).size.width * 0.19,
                                child: TextField(
                                  decoration: InputDecoration(
                                      fillColor:
                                          Color.fromARGB(255, 117, 117, 117),
                                      prefixIcon: Icon(Icons.search),
                                      prefixIconColor:
                                          Color.fromARGB(255, 117, 117, 117),
                                      hintText: 'Cari Chart of Account',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  onSubmitted: (value) {
                                    setState(() {
                                      keyword = value;
                                      VLookupBloc(service: SupabaseService(supabaseClient: widget.client)).add(AkunSearched(keyword: value, data_akun: data_akun));
                                    });
                                    // BlocProvider.of<VLookupCubit>(context).getSearchData(keyword, data_akun);
                                  },
                                ),
                              ),*/
                              SizedBox(width: 20),
                              SizedBox(
                                child: DropdownFilter(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if (newValue != null) {
                                        int count = int.parse(newValue);
                                        total_row = (data_akun.length > count) ? count : data_akun.length;
                                        _selectedEntries = newValue;
                                      }
                                    });
                                  },
                                  content: _selectedEntries,
                                  items: row,
                                ),
                                DataColumn(
                                  label: Text("Nama Akun"),
                                ),
                                DataColumn(
                                  label: Text("Keterangan"),
                                ),
                                DataColumn(
                                  label: Text("Indentasi"),
                                ),
                                DataColumn(
                                  label: Text("Action"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      BlocBuilder<VLookupBloc, SiakState>(
                        /*listener: (context, state) {
                          *//*if (state is SuccessState) {
                            data_akun.clear();
                            data_akun.add(state.datastore);
                          }*//*
                        },*/
                          builder: (_, state) {
                            if (state is FailureState) {
                              return Center(child: Text(state.error));
                            }
                            if (state is SuccessState) {
                              data_akun = state.datastore;
                                return PaginatedDataTable(
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text("No."),
                                    ),
                                    DataColumn(
                                      label: Text("Kode"),
                                    ),
                                    DataColumn(
                                      label: Text("Nama Akun"),
                                    ),
                                    DataColumn(
                                      label: Text("Keterangan"),
                                    ),
                                    DataColumn(
                                      label: Text("Indentasi"),
                                    ),
                                    DataColumn(
                                      label: Text("Action"),
                                    ),
                                  ],
                                  source: RowTableCOA(
                                    contentData: data_akun,
                                    seeDetail: (int index) {
                                      _navigateToDetailCoa(context, {"akun": data_akun[index]});
                                    },
                                    context: context,
                                  ),
                                  sortAscending: true,
                                  rowsPerPage: total_row,
                                  showCheckboxColumn: false,
                                  dataRowHeight: 70,
                                );
                              }
                              if (state is LoadingState) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return const Center(child: Text("No Data"));
                            }
                      )
                    ],
                  ),
                )
              ],
            )
          )
      )
    );
  }
}*/
