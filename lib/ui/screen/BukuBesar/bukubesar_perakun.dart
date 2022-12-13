import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/buku_besar/buku_besar_bloc.dart';
import 'package:sistem_akuntansi/bloc/buku_besar/buku_besar_event.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/Buku_besar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BukuBesarPerAkun extends StatefulWidget {
  final SupabaseClient client;
  final int bulan, tahun;
  final String kode_akun;

  BukuBesarPerAkun({required this.client, required this.bulan, required this.tahun, this.kode_akun = "", Key? key}) : super(key: key);

  @override
  BukuBesarPerAkunState createState() {
    return BukuBesarPerAkunState();
  }
}

class BukuBesarPerAkunState extends State<BukuBesarPerAkun> {
  var tableRow;
  final textAkunController = TextEditingController(text: '');
  String hintText = 'Cari akun';
  String notFoundText = 'Akun tidak ditemukan';
  List<String> items = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];

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

  var list_coa = <Akun>[];
  var list_buku_besar = <VJurnalExpand>[];
  var item_dropdowns = <String>[];

  late BukuBesarBloc _jurnalBloc;
  late VLookupBloc _coaBloc;

  void getAkunText(String? newValue) {
    setState(() {
      var kode_akun = "";
      if(newValue != null) {
        textAkunController.text = newValue;
        int idx = list_coa.indexWhere((element) => element.nama_akun == textAkunController.text);
        kode_akun = list_coa[idx].kode_akun;
      }
      _navigateSelf(context, kode_akun);
    });
  }

  @override
  void initState() {
    super.initState();
    tableRow = new BukuBesarTableData(
      contentData: const <VJurnalExpand>[],
      context: context,
    );

    _jurnalBloc = BukuBesarBloc(service: SupabaseService(supabaseClient: widget.client))..add(BukuBesarFetched(bulan: widget.bulan, tahun: widget.tahun, kode_akun: widget.kode_akun));
    _coaBloc = VLookupBloc(service: SupabaseService(supabaseClient: widget.client))..add(AkunFetched());
  }

  @override
  void dispose() {
    textAkunController.dispose();
    super.dispose();
  }

  void _navigateToListBukuBesar(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 3,
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

  void _navigateSelf(BuildContext context, String kode_akun){
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
              params: {"bulan": widget.bulan, "tahun": widget.tahun, "kode_akun": kode_akun},
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Buku Besar',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => _jurnalBloc),
                BlocProvider(create: (context) => _coaBloc),
              ],
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonBack(
                            onPressed: (){
                              _navigateToListBukuBesar(context);
                            },
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Buku Besar",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color.fromARGB(255, 50, 52, 55)
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${month[widget.bulan-1]} ${widget.tahun}",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 50, 52, 55)
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: (widget.kode_akun != '' ? true : false),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Kode Akun: ",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 50, 52, 55)
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      widget.kode_akun,
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 50, 52, 55)
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                /*Text(
                                  "Akun, Debit",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 50, 52, 55)
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                  BlocConsumer<VLookupBloc, SiakState>(
                      builder: (_, state) {
                        if (state is LoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is FailureState) {
                          return Center(child: Text(state.error));
                        }
                        if (state is SuccessState) {
                          return Container(
                            margin: EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                            color: background2,
                            child: DropdownSearchButton(
                              controller: textAkunController,
                              hintText: 'Cari akun',
                              notFoundText: 'Akun tidak ditemukan',
                              items: item_dropdowns,
                              onChange: getAkunText,
                              isNeedChangeColor: (textAkunController.text != '' ? true : false),
                              colorWhenChanged: yellowTextColor,
                            ),
                          );
                        }
                        return const SizedBox(width: 10);
                      },
                      listener: (_, state) {
                        if (state is SuccessState) {
                          list_coa.clear();
                          list_coa = state.datastore;
                          item_dropdowns = list_coa.map((e) => e.nama_akun).toList();
                        }
                      },
                  ),
                  BlocConsumer<BukuBesarBloc, SiakState>(
                      builder: (_, state) {
                        if (state is LoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state is FailureState) {
                          return Center(child: Text(state.error));
                        }
                        if (state is SuccessState) {
                          var total_saldo = 0;
                          list_buku_besar.forEach((items) {
                            if (items.jenis_transaksi.contains("Debit")) {
                              total_saldo += items.nominal_transaksi;
                            } else {
                              total_saldo -= items.nominal_transaksi;
                            }
                          });

                          return Visibility(
                            visible: (widget.kode_akun != '' ? true : false),
                            child: Container(
                              margin: EdgeInsets.all(25),
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            Text(
                                                'Total Saldo: ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: "Inter",
                                                )
                                            ),
                                            Text(
                                                'Rp $total_saldo',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "Inter",
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*ActionButton(
                                textContent: 'Cetak Buku Besar',
                                onPressed: () {
                                  //
                                }
                            )*/
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: PaginatedDataTable(
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
                                                  "Tanggal",
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
                                                  "Nama Transaksi",
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
                                                    "No. Bukti",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                )
                                            )
                                        ),
                                        DataColumn(
                                            label: Expanded(
                                                child: Container(
                                                  color: greyHeaderColor,
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Keterangan",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                )
                                            )
                                        ),
                                        DataColumn(
                                            label: Expanded(
                                                child: Container(
                                                  color: greyHeaderColor,
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Saldo (Rp.)",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                )
                                            )
                                        ),
                                      ],
                                      source: BukuBesarTableData(
                                        contentData: list_buku_besar,
                                        context: context,
                                      ),
                                      rowsPerPage: 5,
                                      showCheckboxColumn: false,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox(width: 10);
                      },
                      listener: (_, state) {
                        if (state is SuccessState) {
                          list_buku_besar.clear();
                          list_buku_besar = state.datastore;
                        }
                      },
                  ),
                ],
              ),
            )
        )
    );
  }
}


