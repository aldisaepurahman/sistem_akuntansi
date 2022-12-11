import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/utils/V_detail_transaksi.dart';

class DetailTransaksi extends StatefulWidget {
  final SupabaseClient client;

  const DetailTransaksi({required this.client, Key? key}) : super(key: key);

  @override
  DetailTransaksiState createState() {
    return DetailTransaksiState();
  }
}

class DetailTransaksiState extends State<DetailTransaksi> {
  @override
  void dispose() {}

  String tanggal_transaksi = "29/03/2022";
  String nama_transaksi =
      "Penyisihan Piutang Mahasiswa angkatan 2016/2017 D3 Perekam & Inf. Kes";
  String no_bukti = "BK51";
  String nama_jurnal = "Jurnal Pengeluaran BRI STIKes Santo Borromeus";

  int total_row = 1;

  var tableRow;

  @override
  void initState() {
    super.initState();
    tableRow = new RowTableDetail(
        contentDataDebit: contents_debit,
        contentDataKredit: contents_kredit,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Jurnal Umum',
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 2, bukuBesarIndex: 0, client: widget.client)));
                            });
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
                        content: "Jurnal Maret 2022", size: 18, color: hitam)),
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
                                    content: tanggal_transaksi),
                                DetailText(
                                    header: "No Bukti", content: no_bukti)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailText(
                                    header: "Nama Transaksi",
                                    content: nama_transaksi),
                                DetailText(
                                    header: "Nama Jurnal", content: nama_jurnal)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: PaginatedDataTable(
                            rowsPerPage: total_row,
                            dataRowHeight: 150,
                            columns: const [
                              DataColumn(
                                label: HeaderTable(content: "Nama Akun"),
                              ),
                              DataColumn(
                                label: HeaderTable(content: "Saldo"),
                              ),
                              DataColumn(
                                label: HeaderTable(content: "Nama Akun"),
                              ),
                              DataColumn(
                                label: HeaderTable(content: "Saldo"),
                              ),
                            ],
                            source: tableRow,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 40, bottom: 20),
                            width: double.infinity,
                            child: ButtonNoIcon(
                                bg_color: kuning,
                                text_color: hitam,
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                        SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 2, bukuBesarIndex: 0, client: widget.client)));
                                  });
                                },
                                content: "Edit")),
                        Container(
                            margin: EdgeInsets.only(bottom: 25),
                            width: double.infinity,
                            child: ButtonNoIcon(
                                bg_color: background2,
                                text_color: merah,
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
                                              setState(() {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                    SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 2, bukuBesarIndex: 0, client: widget.client)));
                                              });
                                            });
                                      });
                                },
                                content: "Hapus"))
                      ],
                    ))
              ],
            )));
  }
}
