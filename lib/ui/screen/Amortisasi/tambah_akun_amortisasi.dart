import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/AkunAmortisasi.dart';
import 'package:sistem_akuntansi/utils/AmortisasiPendapatan.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class TambahAkunAmortisasiList extends StatefulWidget {

  const TambahAkunAmortisasiList({required this.client, Key? key})
      : super(key: key);

  final SupabaseClient client;

  @override
  TambahAkunAmortisasiListState createState() {
    return TambahAkunAmortisasiListState();
  }
}

class TambahAkunAmortisasiListState extends State<TambahAkunAmortisasiList> {
  void _navigateToAset(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
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

  void _navigateSelf(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 6,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  @override
  void dispose() {
    akun.dispose();
    super.dispose();
  }

  bool show = false;
  bool disable_button = false;

  var tableRow;
  var list_coa = <Akun>[];
  var list_akun_amortisasi = <AmortisasiAkun>[];
  late AmortisasiAkunBloc _akunBloc;
  late VLookupBloc _coaBloc;

  TextEditingController akun = TextEditingController();

  String _selectedAmorType = "Aset";

  String _selectedEntryFilter = '5';
  List<String> entry = ['5', '10', '25', '50', '100'];

  @override
  void initState() {
    super.initState();
    tableRow = new ListAmortisasiTable(
      contentData: <AmortisasiAkun>[],
      onPressed1: () {
        setState(() {}); //belum diset
      },
      onPressed2: (int index) {
        setState(() {}); //belum diset
      },
      context: context,
    );

    _akunBloc = AmortisasiAkunBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAkunFetched());
    _coaBloc = VLookupBloc(service: SupabaseService(supabaseClient: widget.client))..add(AkunFetched());
  }

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;

      akun.text = "";
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;

      akun.text = "";
    });
  }

  var nama_akun_list = <String>[];

  List<String> amortisasi_untuk = [
    "Aset",
    "Pendapatan"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tambah Akun Amortisasi',
        home: Scaffold(
            backgroundColor: background,
            body: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => _akunBloc),
                  BlocProvider(create: (context) => _coaBloc),
                ],
                child: ListView(children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonBack(
                            onPressed: () {
                              setState(() {
                                _navigateToAset(context);
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Akun Amortisasi", size: 32, color: hitam)),
                  Container(
                      width: 30,
                      margin: EdgeInsets.only(left: 25, top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kuning,
                                  padding: const EdgeInsets.all(18)),
                              onPressed: (disable_button ? null : showForm),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 13,
                                        color: hitam,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Tambah Akun Amortisasi",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: hitam,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      )),
                  Visibility(
                      visible: show,
                      child: Container(
                          margin: EdgeInsets.all(25),
                          padding: EdgeInsets.all(25),
                          color: background2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: HeaderText(
                                    content: "Tambah Akun Amortisasi",
                                    size: 18,
                                    color: hitam),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  BlocBuilder<VLookupBloc, SiakState>(
                                      builder: (_, state) {
                                        if (state is LoadingState || state is FailureState) {
                                          return const SizedBox(height: 30, width: 30);
                                        }
                                        if (state is SuccessState) {
                                          list_coa = state.datastore;
                                          nama_akun_list = list_coa.map((e) => e.nama_akun).toList();
                                          return SizedBox(
                                              width:
                                              MediaQuery.of(context).size.width * 0.30,
                                              child: DropdownSearchButton(
                                                  controller: akun,
                                                  hintText: "Masukkan Akun Amortisasi...",
                                                  notFoundText: 'Akun tidak ditemukan',
                                                  items: nama_akun_list,
                                                  onChange: (String? new_value) {},
                                                  isNeedChangeColor: false)
                                          );
                                        }
                                        return const SizedBox(height: 30, width: 30);
                                      },
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: DropdownForm(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedAmorType = newValue!;
                                          });
                                        },
                                        content: _selectedAmorType,
                                        items: amortisasi_untuk,
                                      )
                                  )
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ButtonNoIcon(
                                      bg_color: background2,
                                      text_color: merah,
                                      onPressed: disableForm,
                                      content: "Batal"),
                                  SizedBox(width: 20),
                                  ButtonNoIcon(
                                      bg_color: kuning,
                                      text_color: hitam,
                                      onPressed: () {
                                        var id = list_coa.indexWhere((element) => element.nama_akun == akun.text);
                                        var kode_akun = list_coa[id].kode_akun;
                                        var nama_akun = akun.text;
                                        var jenis = _selectedAmorType;
                                        var id_amortisasi = "${DateFormat(
                                            'yyyy-MM-dd').format(
                                            DateTime.now())}_${getRandomString(7)}";

                                        if (kode_akun != "") {
                                          _akunBloc.add(AmortisasiAkunInserted(
                                              akun: AmortisasiAkun(
                                                  id_amortisasi_akun: id_amortisasi,
                                                kode_akun: kode_akun,
                                                nama_akun: nama_akun,
                                                amortisasi_jenis: jenis
                                              )));

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(Duration(seconds: 2),
                                                        () {
                                                      _navigateSelf(context);
                                                    });
                                                return DialogNoButton(
                                                    content: "Berhasil Ditambahkan!",
                                                    content_detail:
                                                    "Amortisasi Akun baru berhasil ditambahkan",
                                                    path_image:
                                                    'assets/images/tambah_coa.png');
                                              });
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Pastikan nama akun terisi."))
                                          );
                                        }


                                      },
                                      content: "Simpan")
                                ],
                              )
                            ],
                          ))),
                  Container(
                    margin:
                    EdgeInsets.only(top: 25, bottom: 80, right: 25, left: 25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            DropdownFilter(
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    _selectedEntryFilter = newValue;
                                  }
                                });
                              },
                              content: _selectedEntryFilter,
                              items: entry,
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        BlocConsumer<AmortisasiAkunBloc, SiakState>(
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
                                                "Akun",
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
                                    source: ListAmortisasiTable(
                                      contentData: list_akun_amortisasi,
                                      onPressed1: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        }); //belum diset
                                      },
                                      onPressed2: (int index) {
                                        setState(() {
                                          _akunBloc.add(AmortisasiAkunDeleted(id_amortisasi_akun: list_akun_amortisasi[index].id_amortisasi_akun));
                                          Future.delayed(Duration(seconds: 2), () {
                                            _navigateSelf(context);
                                          });
                                        }); //belum diset
                                      },
                                      context: context,
                                    ),
                                    rowsPerPage: int.parse(_selectedEntryFilter),
                                    showCheckboxColumn: false,
                                    dataRowHeight: 70,
                                    horizontalMargin: 0,
                                    columnSpacing: 0,
                                  ),
                                );
                              }
                              return const SizedBox(height: 30, width: 30);
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_akun_amortisasi.clear();
                                list_akun_amortisasi = state.datastore;
                              }
                            },
                        )
                      ],
                    ),
                  )
                ])
            )));
  }
}
