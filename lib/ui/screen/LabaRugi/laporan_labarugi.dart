import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/laba_rugi/laba_rugi_bloc.dart';
import 'package:sistem_akuntansi/bloc/laba_rugi/laba_rugi_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vneraca_lajur.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/screen/LabaRugi/labarugi_pdf.dart';
import 'package:sistem_akuntansi/utils/currency_format.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class LaporanLabaRugi extends StatefulWidget {
  const LaporanLabaRugi(
      {required this.client, required this.bulan, required this.tahun, Key? key})
      : super(key: key);

  final SupabaseClient client;
  final String bulan;
  final int tahun;

  @override
  LaporanLabaRugiState createState() {
    return LaporanLabaRugiState();
  }

  static int hitung_jumlah(List<Map> data, String column) {
    int total = 0;
    data.forEach((item) {
      total += item[column] as int;
    });

    return total;
  }
}

class LaporanLabaRugiState extends State<LaporanLabaRugi> {
  @override
  void dispose() {
    super.dispose();
  }

  /*int total_debit_pendapatan =
      LaporanLabaRugi.hitung_jumlah(pendapatan, 'debit');
  int total_kredit_pendapatan =
      LaporanLabaRugi.hitung_jumlah(pendapatan, 'kredit');

  int total_debit_beban = LaporanLabaRugi.hitung_jumlah(beban, 'debit');
  int total_kredit_beban = LaporanLabaRugi.hitung_jumlah(beban, 'kredit');*/

  void _navigateToLabaRugi(BuildContext context){
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
  }

  int total_debit_pendapatan = 0;
  int total_kredit_pendapatan = 0;

  int total_debit_beban = 0;
  int total_kredit_beban = 0;

  late LabaRugiBloc _labaRugiBloc;
  var list_laba = <VNeracaLajur>[];

  var datalistpendapatan = <Map>[];
  var datalistbeban = <Map>[];

  @override
  void initState() {
    super.initState();

    _labaRugiBloc =
    LabaRugiBloc(service: SupabaseService(supabaseClient: widget.client))
      ..add(LabaRugiFetched(bulan: widget.bulan, tahun: widget.tahun));
  }

  void showForm() {
    setState(() {
      /*show = true;
      disable_button = true;*/
    });
  }

  List<DataRow> _createRows(List<Map> item) {
    return item
        .map((item) =>
        DataRow(cells: [
          DataCell(SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 5 - 50,
            child: Container(
              child: Text(
                item["nama_akun"],
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ),
          )),
          DataCell(SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 5 - 50,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                CurrencyFormat.convertToCurrency(item["debit"]),
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ),
          )),
          DataCell(SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 5 - 50,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                CurrencyFormat.convertToCurrency(item["kredit"]),
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ),
          )),
          DataCell(SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width / 5 - 50,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ),
          ))
        ]))
        .toList();
  }

  String periode = "31 Maret 2022";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Laporan Laba Rugi',
        home: Scaffold(
            backgroundColor: background,
            body: BlocProvider<LabaRugiBloc>(
              create: (context) => _labaRugiBloc,
              child: ListView(
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
                                _navigateToLabaRugi(context);
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
                          content: "Bulan ${widget.bulan} ${widget.tahun}", size: 18, color: hitam)),
                  BlocConsumer<LabaRugiBloc, SiakState>(
                    builder: (_, state) {
                      if (state is LoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is FailureState) {
                        return Center(child: Text(state.error));
                      }
                      if (state is SuccessState) {
                        datalistbeban.clear();
                        datalistpendapatan.clear();
                        total_kredit_beban = 0;
                        total_debit_beban = 0;
                        total_kredit_pendapatan = 0;
                        total_debit_pendapatan = 0;

                        list_laba.forEach((coa) {
                          var mapData = {};
                          mapData["nama_akun"] = coa.nama_akun;
                          if (coa.kode_akun.contains("2.4")) {
                            if (coa.neraca_saldo_disesuaikan! >= 0) {
                              mapData["debit"] = coa.neraca_saldo_disesuaikan;
                              mapData["kredit"] = 0;
                              total_debit_pendapatan += coa.neraca_saldo_disesuaikan!;
                            } else {
                              mapData["debit"] = 0;
                              mapData["kredit"] = coa.neraca_saldo_disesuaikan?.abs();
                              total_kredit_pendapatan += coa.neraca_saldo_disesuaikan!.abs();
                            }
                            datalistpendapatan.add(mapData);
                          } else if (coa.kode_akun.contains("2.5")) {
                            if (coa.neraca_saldo_disesuaikan! >= 0) {
                              mapData["debit"] = coa.neraca_saldo_disesuaikan;
                              mapData["kredit"] = 0;
                              total_debit_beban += coa.neraca_saldo_disesuaikan!;
                            } else {
                              mapData["debit"] = 0;
                              mapData["kredit"] = coa.neraca_saldo_disesuaikan?.abs();
                              total_kredit_beban += coa.neraca_saldo_disesuaikan!.abs();
                            }
                            datalistbeban.add(mapData);
                          }
                        });

                        return Container(
                          margin: EdgeInsets.only(
                              top: 25, bottom: 150, right: 25, left: 25),
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
                                      onPressed: () => labarugi_pdf(datalistpendapatan, datalistbeban,
                                          widget.bulan, widget.tahun),
                                      content: "Cetak Laporan")
                                ],
                              ),
                              SizedBox(height: 25),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 25),
                                  child: Text(
                                    "STIKes Santo Borromeus",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontSize: 15,
                                        color: hitam,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Laporan Laba Rugi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontSize: 15,
                                        color: hitam,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5, bottom: 25),
                                  child: Text(
                                    "Periode ${widget.bulan} ${widget.tahun}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontSize: 15,
                                        color: hitam),
                                  )),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                                width: double.infinity,
                                color: kuning,
                                child: Text(
                                    "Laba : Rp ${CurrencyFormat.convertToCurrency(((total_kredit_pendapatan -
                                        total_debit_pendapatan) +
                                        (total_kredit_beban -
                                            total_debit_beban)))}",
                                    style: TextStyle(
                                        fontFamily: "Inner",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: hitam)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Pendapatan"),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                      ],
                                      showCheckboxColumn: false,
                                      rows: _createRows(datalistpendapatan),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text("Pendapatan Bersih",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam)),
                                        Text(
                                            "Rp ${CurrencyFormat.convertToCurrency((total_kredit_pendapatan -
                                                total_debit_pendapatan))}",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text("Beban Usaha"),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                        ),
                                      ],
                                      showCheckboxColumn: false,
                                      rows: _createRows(datalistbeban),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text("Total Beban",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam)),
                                        Text(
                                            "Rp ${CurrencyFormat.convertToCurrency((total_kredit_beban - total_debit_beban))}",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text("Laba Bersih",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam)),
                                        Text(
                                            "Rp ${CurrencyFormat.convertToCurrency(((total_kredit_pendapatan -
                                                total_debit_pendapatan) +
                                                (total_kredit_beban -
                                                    total_debit_beban)))}",
                                            style: TextStyle(
                                                fontFamily: "Inner",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: hitam))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox(height: 30, width: 30);
                    },
                    listener: (_, state) {
                      if (state is SuccessState) {
                        list_laba.clear();
                        list_laba = state.datastore;
                      }
                    },
                  )
                ],
              ),
            )));
  }
}
