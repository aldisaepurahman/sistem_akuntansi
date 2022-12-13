import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/utils/V_detail_transaksi.dart';

class DetailTransaksiPenyesuaian extends StatefulWidget {
  final SupabaseClient client;
  final int bulan, tahun, id_jurnal;
  final Map<String, List<VJurnalExpand>> transaksi;

  const DetailTransaksiPenyesuaian({required this.client, required this.bulan, required this.tahun, required this.id_jurnal, required this.transaksi, Key? key}) : super(key: key);

  @override
  DetailTransaksiPenyesuaianState createState() {
    return DetailTransaksiPenyesuaianState();
  }
}

class DetailTransaksiPenyesuaianState extends State<DetailTransaksiPenyesuaian> {
  @override
  void dispose() {}

  String tanggal_transaksi = "29/03/2022";
  String nama_transaksi =
      "Penyisihan Piutang Mahasiswa angkatan 2016/2017 D3 Perekam & Inf. Kes";
  String no_bukti = "BK51";
  String nama_jurnal = "Jurnal Pengeluaran BRI STIKes Santo Borromeus";

  int total_row = 1;

  late VJurnalBloc _jurnalBloc;

  var tableRow;
  var tempValue = <VJurnalExpand>[];
  var dataDebit, dataKredit;

  void _navigateToDaftarTransaksi(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
                index: 7,
                coaIndex: 0,
                jurnalUmumIndex: 0,
                bukuBesarIndex: 0,
                labaRugiIndex: 0,
                neracaLajurIndex: 0,
                amortisasiIndex: 0,
                jurnalPenyesuaianIndex: 2,
                client: widget.client,
              params: {"bulan": widget.bulan, "tahun": widget.tahun, "id_jurnal": widget.id_jurnal},
            )
    )
    );
  }

  @override
  void initState() {
    super.initState();
    widget.transaksi.forEach((key, value) {
      value.forEach((element) {
        tempValue.add(element);
      });
    });

    dataDebit = tempValue.where((element) => element.jenis_transaksi == "Debit").toList();
    dataKredit = tempValue.where((element) => element.jenis_transaksi == "Kredit").toList();

    tableRow = new RowTableDetail(
        contentDataDebit: dataDebit,
        contentDataKredit: dataKredit,
        context: context);

    _jurnalBloc = VJurnalBloc(service: SupabaseService(supabaseClient: widget.client));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Jurnal Umum',
        home: Scaffold(
            backgroundColor: background,
            body: BlocProvider<VJurnalBloc>(
              create: (context) => _jurnalBloc,
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
                              _navigateToDaftarTransaksi(context);
                            },
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Daftar Transaksi", size: 32, color: hitam)),
                  Container(
                      margin: EdgeInsets.only(bottom: 15, left: 25),
                      child: HeaderText(
                          content: "Jurnal Desember ${widget.tahun}", size: 18, color: hitam)),
                  Container(
                      margin: EdgeInsets.all(25),
                      padding: EdgeInsets.all(25),
                      color: background2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: const Text(
                                "Detail Transaksi",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 255, 204, 0)
                                ),
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailText(
                                      header: "Tanggal Transaksi",
                                      content: DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.transaksi.keys.elementAt(0).split("+")[2]))),
                                  DetailText(
                                      header: "No Bukti", content: widget.transaksi.keys.elementAt(0).split("+")[4])
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailText(
                                      header: "Nama Transaksi",
                                      content: widget.transaksi.keys.elementAt(0).split("+")[1]),
                                  DetailText(
                                      header: "Nama Jurnal", content: widget.transaksi.keys.elementAt(0).split("+")[5])
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            width: double.infinity,
                            child: PaginatedDataTable(
                              rowsPerPage: total_row,
                              dataRowHeight: 150,
                              columns: [
                                DataColumn(
                                  label: Expanded(
                                      child: Container(
                                        color: greyHeaderColor,
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Akun Debit",
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
                                          "Saldo Debit (Rp.)",
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
                                          "Akun Kredit",
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
                                          "Saldo Kredit (Rp.)",
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
                              horizontalMargin: 0,
                              columnSpacing: 0,
                            ),
                          ),
                          SizedBox(height: 30),
                          /*Container(
                            margin: EdgeInsets.only(top: 40, bottom: 20),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 204, 0),
                                  padding: EdgeInsets.all(20)),
                              onPressed: () {
                                _navigateToDaftarTransaksi(context);
                              },
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Color.fromARGB(255, 50, 52, 55),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),*/
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                                  padding: EdgeInsets.all(20)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog2Button(
                                          content: "Hapus Transaksi",
                                          content_detail:
                                          "Anda yakin ingin menghapus data ini?",
                                          path_image: 'assets/images/hapus_coa.png',
                                          button1: "Tetap Simpan",
                                          button2: "Ya, Hapus",
                                          onPressed1: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          onPressed2: () {
                                            _jurnalBloc.add(JurnalDeleted(id_transaksi: tempValue[0].id_transaksi));
                                            Future.delayed(Duration(seconds: 2), () {
                                              _navigateToDaftarTransaksi(context);
                                            });
                                          });
                                    });
                              },
                              child: const Text(
                                "Hapus",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: Color.fromARGB(255, 245, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )));
  }
}
