import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_event.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class AmortisasiAsetList extends StatefulWidget {
  const AmortisasiAsetList({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  AmortisasiAsetListState createState() {
    return AmortisasiAsetListState();
  }
}

class AmortisasiAsetListState extends State<AmortisasiAsetList> {
  DateTime? _saat_perolehan;

  bool show = false;
  bool disable_button = false;

  var tableRow;
  var list_aset = <AmortisasiAset>[];
  var list_coa = <AmortisasiAkun>[];
  late AmortisasiAsetBloc _asetBloc;
  late AmortisasiAkunBloc _akunBloc;

  Map<int, String> listbulan = {
    1: "Januari",
    2: "Februari",
    3: "Maret",
    4: "April",
    5: "Mei",
    6: "Juni",
    7: "Juli",
    8: "Agustus",
    9: "September",
    10: "Oktober",
    11: "November",
    12: "Desember"
  };

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
              amortisasiIndex: 0,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToDetailAset(BuildContext context, AmortisasiAset aset){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 1,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
              params: {"aset": aset},
            )
    )
    );
  }

  void _navigateToPendapatan(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 3,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToTambahAkun(BuildContext context){
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
  void initState() {
    super.initState();
    _saat_perolehan = DateTime.now();
    tableRow = new AmortisasiAsetTable(
      contentData: const <AmortisasiAset>[],
      seeDetail: (int index) {
        setState(() {
          _navigateToDetailAset(context, AmortisasiAset());
        });
      },
      context: context,
    );

    _asetBloc = AmortisasiAsetBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAsetFetched());
    _akunBloc = AmortisasiAkunBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAkunFetched());
  }

  void showForm() {
    setState(() {
      keterangan.text = "";
      nilai_perolehan.text = "";
      masa_guna.text = "";
      akumulasi_penyusutan_tahun_lalu.text = "";
      saat_perolehan.text = "";
      akun.text = "";

      show = true;
      disable_button = true;
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;

      keterangan.text = "";
      nilai_perolehan.text = "";
      masa_guna.text = "";
      akumulasi_penyusutan_tahun_lalu.text = "";
      saat_perolehan.text = "";
      akun.text = "";
    });
  }

  //Inisialisasi untuk Dropdown
  TextEditingController keterangan = TextEditingController();
  TextEditingController nilai_perolehan = TextEditingController();
  TextEditingController masa_guna = TextEditingController();
  TextEditingController akumulasi_penyusutan_tahun_lalu = TextEditingController();
  TextEditingController saat_perolehan = TextEditingController();
  TextEditingController akun = TextEditingController();
  TextEditingController bunga = TextEditingController();

  @override
  void dispose(){
    keterangan.dispose();
    nilai_perolehan.dispose();
    masa_guna.dispose();
    akumulasi_penyusutan_tahun_lalu.dispose();
    saat_perolehan.dispose();
    akun.dispose();
    bunga.dispose();
    super.dispose();
  }

  String _selectedAkunFilter = 'Beban Kesekretariatan';
  String _selectedYearFilter = '2022';
  String _selectedEntryFilter = '5';

  String _selectedAkunInsert = 'Beban Kesekretariatan';
  String _selectedYearInsert = '2022';

  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];
  List<String> year = ['2021', '2022', '2023', '2024', '2025'];
  List<String> entry = ['5', '10', '25', '50', '100'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Amortisasi Aset',
        home: Scaffold(
            backgroundColor: background,
            body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => _asetBloc),
                BlocProvider(create: (context) => _akunBloc),
              ],
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Amortisasi Aset", size: 32, color: hitam)),
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
                                        "Tambah Amortisasi",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: hitam,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kuning,
                                  padding: const EdgeInsets.all(18)),
                              onPressed: () {
                                setState(() {
                                  _navigateToPendapatan(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.list_alt_rounded,
                                        size: 13,
                                        color: hitam,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Amortisasi Pendapatan",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: hitam,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          const SizedBox(width: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kuning,
                                  padding: const EdgeInsets.all(18)),
                              onPressed: () {
                                setState(() {
                                  _navigateToTambahAkun(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.list_alt_rounded,
                                        size: 13,
                                        color: hitam,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Akun Amortisasi",
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
                                  content: "Tambah Amortisasi Aset",
                                  size: 18,
                                  color: hitam),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: TextForm(
                                          hintText: "Masukkan keterangan...",
                                          textController: keterangan)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextForm(
                                          hintText: "Masukkan masa guna...",
                                          textController: masa_guna)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextForm(
                                        hintText: "Masukkan nilai perolehan (Rp.)...",
                                        textController: nilai_perolehan),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: TextForm(
                                        hintText: "Masukkan Persentase bunga (%)...",
                                        textController: bunga),
                                  )
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      child: TextForm(
                                        hintText:
                                        "Masukkan penyusutan tahun lalu (Rp.)...",
                                        textController:
                                        akumulasi_penyusutan_tahun_lalu,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  BlocBuilder<AmortisasiAkunBloc, SiakState>(
                                      builder: (_, state) {
                                        if (state is LoadingState || state is FailureState) {
                                          return const SizedBox(width: 30);
                                        }
                                        if (state is SuccessState) {
                                          list_coa = state.datastore;
                                          namaAkunList.clear();
                                          namaAkunList = list_coa.where((element) => element.amortisasi_jenis == "Aset").map((e) => e.nama_akun).toList();
                                          return Expanded(
                                              child: DropdownSearchButton(
                                                  controller: akun,
                                                  hintText: "Masukkan Akun Amortisasi...",
                                                  notFoundText: 'Akun tidak ditemukan',
                                                  items: namaAkunList,
                                                  onChange: (String? new_value) {},
                                                  isNeedChangeColor: false));
                                        }
                                        return const SizedBox(width: 30);
                                      },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(bottom: 3),
                                          child: TextField(
                                            controller: saat_perolehan,
                                            style: TextStyle(fontSize: 13),
                                            readOnly: true,
                                            onTap: () {
                                              showMonthPicker(
                                                  unselectedMonthTextColor:
                                                  hitam,
                                                  headerColor: kuning,
                                                  headerTextColor: hitam,
                                                  selectedMonthBackgroundColor:
                                                  kuning,
                                                  selectedMonthTextColor:
                                                  hitam,
                                                  context: context,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                  initialDate: DateTime.now())
                                                  .then((date) {
                                                if (date != null) {
                                                  setState(() {
                                                    _saat_perolehan = date;
                                                    String formattedDate = DateFormat()
                                                        .add_yM()
                                                        .format(_saat_perolehan!);
                                                    saat_perolehan.text = formattedDate;
                                                  });
                                                }
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText:
                                                "Masukkan saat perolehan",
                                                prefixIcon:
                                                Icon(Icons.calendar_today),
                                                contentPadding:
                                                const EdgeInsets.all(5),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8))),
                                          )))
                                ]),
                            SizedBox(
                              height: 30,
                            ),
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
                                      var id_amortisasi_aset = "${DateFormat(
                                          'yyyy-MM-dd').format(
                                          DateTime.now())}_${getRandomString(9)}";
                                      var id = list_coa.indexWhere((element) => element.nama_akun == akun.text);
                                      var id_amortisasi_akun = list_coa[id].id_amortisasi_akun;
                                      var text_keterangan = keterangan.text;
                                      var masaGuna = 0;

                                      if (masa_guna.text.isNotEmpty) {
                                        masaGuna = int.parse(masa_guna.text);
                                      }
                                      var perolehan = 0;
                                      if (nilai_perolehan.text.isNotEmpty) {
                                        perolehan = int.parse(nilai_perolehan.text);
                                      }

                                      var penyusutan_thn_lalu = 0;
                                      if (akumulasi_penyusutan_tahun_lalu.text.isNotEmpty) {
                                        penyusutan_thn_lalu = int.parse(akumulasi_penyusutan_tahun_lalu.text);
                                      }

                                      var penyusutan_sekarang = (perolehan/4)~/12;
                                      var tahun = DateTime.now().year;
                                      var saatPerolehan = saat_perolehan.text.split("/");
                                      var bulan_perolehan = "";
                                      bulan_perolehan = listbulan[int.parse(saatPerolehan[0])]!;
                                      var tahun_perolehan = int.parse(saatPerolehan[1]);

                                      if (id_amortisasi_akun.isNotEmpty && text_keterangan.isNotEmpty &&
                                      bulan_perolehan.isNotEmpty && masaGuna > 0 && penyusutan_thn_lalu > 0 && perolehan > 0) {
                                        _asetBloc.add(AmortisasiAsetInserted(
                                            aset: AmortisasiAset(
                                              id_amortisasi_aset: id_amortisasi_aset,
                                              id_amortisasi_akun: id_amortisasi_akun,
                                              keterangan: text_keterangan,
                                              masa_guna: masaGuna,
                                              nilai_awal: perolehan,
                                              akumulasi: penyusutan_thn_lalu,
                                              penyusutan: penyusutan_sekarang,
                                              tahun: tahun,
                                              tahun_perolehan: tahun_perolehan,
                                              bulan_perolehan: bulan_perolehan
                                            )
                                        ));

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
                                                  "Amortisasi Aset baru berhasil ditambahkan",
                                                  path_image:
                                                  'assets/images/tambah_coa.png');
                                            });
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Pastikan semua kolom inputan terisi."))
                                        );
                                      }
                                    },
                                    content: "Simpan")
                              ],
                            )
                          ],
                        ),
                      )),
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
                            /*DropdownFilter(
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
                          SizedBox(width: 20),
                          DropdownFilter(
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue != null) {
                                  _selectedAkunFilter = newValue;
                                }
                              });
                            },
                            content: _selectedAkunFilter,
                            items: namaAkunList,
                          ),
                          SizedBox(width: 20),*/
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
                        BlocConsumer<AmortisasiAsetBloc, SiakState>(
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
                                                "Keterangan",
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
                                                "Saat Perolehan",
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
                                                "Masa Guna",
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
                                                "Nilai Perolehan (Rp.)",
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
                                                "Penyusutan (Rp.)",
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
                                    source: AmortisasiAsetTable(
                                      contentData: list_aset,
                                      seeDetail: (int index) {
                                        setState(() {
                                          _navigateToDetailAset(context, list_aset[index]);
                                        });
                                      },
                                      context: context,
                                    ),
                                    rowsPerPage: int.parse(_selectedEntryFilter),
                                    showCheckboxColumn: false,
                                    dataRowHeight: 70,
                                    columnSpacing: 0,
                                    horizontalMargin: 0,
                                  ),
                                );
                              }
                              return const SizedBox(height: 30, width: 30);
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_aset.clear();
                                list_aset = state.datastore;
                              }
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
