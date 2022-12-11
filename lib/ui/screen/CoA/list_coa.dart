// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
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
  String kode_akun = "1.1-1104-01-02-01-05-05";
  String nama_akun =
      "Penyisihan Piutang Mahasiswa angkatan 2016/2017 D3 Perekam & Inf. Kes";
  String keterangan = "Akun, Debit";
  String kode_reference = "2";
  String saldo_awal = "-";
  String saldo_awal_baru = "Rp 29.702.072";
  var tableRow;

  int total_row = 5;

  String _selectedEntries = '5';

  List<String> row = ['5', '10', '25', '50', '100'];

  @override
  void initState() {
    super.initState();
    tableRow = new RowTableCOA(
      contentData: const <Akun>[],
      seeDetail: (int index) {
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SideNavigationBar(
                  index: 1,
                  coaIndex: 2,
                  jurnalUmumIndex: 0,
                  bukuBesarIndex: 1,
                  client: widget.client)));
        });
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
                create: (BuildContext context) => VLookupBloc(
                    service: SupabaseService(supabaseClient: widget.client))
                  ..add(AkunFetched()),
                child: ListView(
                  children: [
                    /*Container(
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
                    )),*/
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
                      margin: EdgeInsets.only(
                          top: 25, bottom: 50, left: 25, right: 25),
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
                                      setState(() {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SideNavigationBar(
                                                        index: 1,
                                                        coaIndex: 1,
                                                        jurnalUmumIndex: 0,
                                                        bukuBesarIndex: 0,
                                                        client:
                                                            widget.client)));
                                      });
                                    },
                                    child: Row(
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
                          SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            child: PaginatedDataTable(
                              source: tableRow,
                              rowsPerPage: total_row,
                              showCheckboxColumn: false,
                              dataRowHeight: 70,
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
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
                      
//=======
                                              /*color:
                                              Color.fromARGB(255, 50, 52, 55),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                        ],
                      ),
                      SizedBox(height: 25),*/
                      /*PaginatedDataTable(
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
                        source: BlocBuilder<VLookupBloc, VLookupState>(
                      BlocBuilder<VLookupBloc, VLookupState>(
                          builder: (context, state) {
                            switch (state.status) {
                              case SystemStatus.failure:
                                return Center(child: Text(state.error));
                              case SystemStatus.success:
                                if (state.list_coa.isEmpty) {
                                  return const Center(child: Text("No Data"));
                                }
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
                                    contentData: state.list_coa.where((coa) => coa.keterangan_akun != "Header").toList(),
                                    seeDetail: (int index) {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              SideNavigationBar(index: 1, coaIndex: 2, bukuBesarIndex: 0, client: widget.client, params: state.list_coa[index])));
                                    },
                                    context: context,
                                  ),
                                  rowsPerPage: total_row,
                                  showCheckboxColumn: false,
                                  dataRowHeight: 70,
                                );
                              case SystemStatus.loading:
                                return const Center(child: CircularProgressIndicator());
                            }
                          },
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
