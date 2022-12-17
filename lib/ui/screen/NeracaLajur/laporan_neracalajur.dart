import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/neraca_lajur/neraca_lajur_bloc.dart';
import 'package:sistem_akuntansi/bloc/neraca_lajur/neraca_lajur_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vneraca_lajur.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/screen/NeracaLajur/neraca_pdf.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../components/navigationBar.dart';

class LaporanNeracaLajur extends StatefulWidget {
  const LaporanNeracaLajur({required this.client, required this.bulan, required this.tahun, Key? key}) : super(key: key);

  final SupabaseClient client;
  final String bulan;
  final int tahun;

  @override
  LaporanNeracaLajurState createState() {
    return LaporanNeracaLajurState();
  }
}

class LaporanNeracaLajurState extends State<LaporanNeracaLajur> {
  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToNeracaLajur(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 4,
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

  bool show = false;
  bool disable_button = false;

  late NeracaLajurBloc _neracaBloc;
  var list_neraca = <VNeracaLajur>[];

  @override
  void initState() {
    super.initState();

    _neracaBloc =
    NeracaLajurBloc(service: SupabaseService(supabaseClient: widget.client))
      ..add(NeracaLajurFetched(bulan: widget.bulan, tahun: widget.tahun));
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
            body: BlocProvider<NeracaLajurBloc>(
              create: (context) => _neracaBloc,
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
                                _navigateToNeracaLajur(context);
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Neraca Lajur", size: 32, color: hitam)),
                  Container(
                      margin: EdgeInsets.only(bottom: 15, left: 25),
                      child: HeaderText(
                          content: "Bulan ${widget.bulan} ${widget.tahun}", size: 18, color: hitam)),
                  Container(
                    margin:
                    EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocConsumer<NeracaLajurBloc, SiakState>(
                            builder: (_, state) {
                              if (state is LoadingState || state is FailureState) {
                                return const SizedBox(height: 25);
                              }
                              if (state is SuccessState) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ButtonNoIcon(
                                        bg_color: kuning,
                                        text_color: hitam,
                                        onPressed: () => neraca_pdf(list_neraca, widget.bulan, widget.tahun),
                                        content: "Cetak Neraca Lajur")
                                  ],
                                );
                              }
                              return const SizedBox(height: 25);
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_neraca.clear();
                                list_neraca = state.datastore;
                              }
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
