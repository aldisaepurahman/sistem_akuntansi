import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/detail_akun/detail_akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/detail_akun/detail_akun_state.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/saldo.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailCOA extends StatefulWidget {
  const DetailCOA({required this.client, required this.akun, Key? key})
      : super(key: key);

  final Akun akun;
  final SupabaseClient client;

  @override
  DetailCOAState createState() {
    return DetailCOAState();
  }
}

class DetailCOAState extends State<DetailCOA> {
  void _navigateToEditCoa(BuildContext context, Map<String, dynamic> params){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 1,
          coaIndex: 3,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          labaRugiIndex: 0,
          neracaLajurIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
          params: params,
        )
      )
    );
  }

  void _navigateToListCoa(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                SideNavigationBar(
                    index: 1,
                    coaIndex: 0,
                    jurnalUmumIndex: 0,
                    bukuBesarIndex: 0,
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
  void dispose() {
    super.dispose();
  }

  String kode_akun = "1.1-1104-01-02-01-05-05";
  String nama_akun =
      "Penyisihan Piutang Mahasiswa angkatan 2016/2017 D3 Perekam & Inf. Kes";
  String keterangan = "Akun, Debit";
  String indentasi = "2";
  String saldo_awal = "-";
  String saldo_awal_baru = "Rp 29.702.072";
  Saldo akun_saldo = Saldo(saldo: 0, bulan: "", tahun: 0, kode_akun: "");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Detail Chart of Account',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: BlocProvider<DetailAkunBloc>(
              create: (BuildContext context) => DetailAkunBloc(
                  service: SupabaseService(supabaseClient: widget.client))
                ..add(AkunDetailed(kode: widget.akun.kode_akun)),
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonBack(
                          /*onPressed: () {
                            _navigateToEditCoa(context);
                          },*/
                            onPressed: () {
                              setState(() {
                                _navigateToListCoa(context);
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
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
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: const Text(
                          "Detail CoA",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromARGB(255, 255, 204, 0)),
                        )),
                        BlocBuilder<DetailAkunBloc, DetailAkunState>(
                          builder: (_, state) {
                            switch (state.status) {
                              case SystemStatus.loading:
                                return const Center(child: CircularProgressIndicator());
                              case SystemStatus.success:
                                akun_saldo.id_saldo = state.datastate.id_saldo;
                                akun_saldo.saldo = state.datastate.saldo;
                                akun_saldo.kode_akun = state.datastate.kode;
                                akun_saldo.bulan = state.datastate.bulan;
                                akun_saldo.tahun = state.datastate.tahun;
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailText(
                                            header: "Kode",
                                            content: widget.akun.kode_akun),
                                        DetailText(
                                            header: "Keterangan",
                                            content:
                                                widget.akun.keterangan_akun),
                                        DetailText(
                                            header: "Saldo Awal Bulan ini",
                                            content: (state.datastate.id_saldo > 0 && state.datastate.saldo > 0)
                                                ? state.datastate.saldo.toString()
                                                : "0 (tentukan saldo awal bulan ini)")
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailText(
                                            header: "Nama Akun",
                                            content: widget.akun.nama_akun),
                                        DetailText(
                                            header: "Indentasi",
                                            content: widget.akun.indentasi.toString()),
                                      ],
                                    ),
                                  ],
                                );
                              case SystemStatus.failure:
                                return Center(child: Text(state.error));
                            }
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40, bottom: 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 204, 0),
                                padding: EdgeInsets.all(20)),
                            onPressed: () {
                              setState(() {
                                _navigateToEditCoa(context, {"akun": widget.akun, "akun_saldo": akun_saldo});
                              });
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
                        ),
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
                                        content: "Hapus Chart of Account",
                                        content_detail:
                                            "Anda yakin ingin menghapus data ini?",
                                        path_image:
                                            'assets/images/hapus_coa.png',
                                        button1: "Tetap Simpan",
                                        button2: "Ya, Hapus",
                                        onPressed1: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        onPressed2: () {
                                          AkunBloc(
                                              service: SupabaseService(supabaseClient: widget.client))
                                            ..add(AkunDeleted(kode_akun: widget.akun.kode_akun));
                                          Future.delayed(Duration(seconds: 2), () {
                                            _navigateToListCoa(context);
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
