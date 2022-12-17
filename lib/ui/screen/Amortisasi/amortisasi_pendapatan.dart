import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_event.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_pendapatan/amortisasi_pendapatan_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_pendapatan/amortisasi_pendapatan_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class AmortisasiPendapatanList extends StatefulWidget {
  const AmortisasiPendapatanList({required this.client, Key? key})
      : super(key: key);

  final SupabaseClient client;

  @override
  AmortisasiPendapatanListState createState() {
    return AmortisasiPendapatanListState();
  }
}

class AmortisasiPendapatanListState extends State<AmortisasiPendapatanList> {
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
              amortisasiIndex: 3,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )
    )
    );
  }

  void _navigateToDetailPendapatan(BuildContext context, AmortisasiPendapatan pendapatan){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 4,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
              params: {"pendapatan": pendapatan},
            )
    )
    );
  }

  bool show = false;
  bool disable_button = false;

  var tableRow;
  var list_pendapatan = <AmortisasiPendapatan>[];
  var list_coa = <AmortisasiAkun>[];
  late AmortisasiPendapatanBloc _pendapatanBloc;
  late AmortisasiAkunBloc _akunBloc;

  @override
  void initState() {
    super.initState();
    _pendapatanBloc = AmortisasiPendapatanBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiPendapatanFetched());
    _akunBloc = AmortisasiAkunBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAkunFetched());
    tableRow = new AmortisasiPendapatanTable(
      contentData: list_pendapatan,
      seeDetail: (int index) {
        setState(() {
          _navigateToDetailPendapatan(context, AmortisasiPendapatan());
        });
      },
      context: context,
    );
  }

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;

      keterangan.text = "";
      total_harga.text = "";
      jumlah_mahasiswa.text = "";
      akun.text = "";
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;

      keterangan.text = "";
      total_harga.text = "";
      jumlah_mahasiswa.text = "";
      akun.text = "";
    });
  }

  @override
  void dispose(){
    keterangan.dispose();
    total_harga.dispose();
    jumlah_mahasiswa.dispose();
    akun.dispose();
    super.dispose();
  }

  //Inisialisasi untuk Dropdown
  TextEditingController keterangan = TextEditingController();
  TextEditingController total_harga = TextEditingController();
  TextEditingController jumlah_mahasiswa = TextEditingController();
  TextEditingController akun = TextEditingController();
  TextEditingController thn_angkatan = TextEditingController();

  String _selectedSemesterFilter = 'Ganjil';
  String _selectedAkunFilter = 'Beban Kesekretariatan';
  String _selectedEntryFilter = '5';

  String _selectedSemesterInsert = 'Ganjil';
  String _selectedAkunInsert = 'Beban Kesekretariatan';

  List<String> semester = ['Ganjil', 'Genap'];
  List<String> semester_filter = ['Ganjil', 'Genap'];

  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];
  List<String> entry = ['5', '10', '25', '50', '100'];
  List<String> namaAkunListFilter = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Amortisasi Pendapatan',
        home: Scaffold(
            backgroundColor: background,
            body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => _pendapatanBloc),
                BlocProvider(create: (context) => _akunBloc)
              ],
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
                                _navigateToAset(context);
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                          content: "Amortisasi Pendapatan",
                          size: 32,
                          color: hitam)),
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
                                  content: "Tambah Amortisasi Pendapatan",
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
                                          hintText: "Masukkan total harga...",
                                          textController: total_harga,
                                          label: "Jumlah (Rp.)")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DropdownForm(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedSemesterInsert = newValue!;
                                          });
                                        },
                                        content: _selectedSemesterInsert,
                                        items: semester,
                                        label: "Pilih Semester"),
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
                                          "Masukkan tahun masuk (Misal: 2019)...",
                                          textController: thn_angkatan)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextForm(
                                          hintText:
                                          "Masukkan jumlah mahasiswa...",
                                          textController: jumlah_mahasiswa)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  BlocConsumer<AmortisasiAkunBloc, SiakState>(
                                    listener: (_, state) {},
                                    builder: (_, state) {
                                      if (state is LoadingState || state is FailureState) {
                                        return const SizedBox(width: 30);
                                      }
                                      if (state is SuccessState) {
                                        list_coa = state.datastore;
                                        namaAkunList.clear();
                                        namaAkunList = list_coa.where((element) => element.amortisasi_jenis == "Pendapatan").map((e) => e.nama_akun).toList();
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
                                      var id_amortisasi_pendapatan = "${DateFormat(
                                          'yyyy-MM-dd').format(
                                          DateTime.now())}_${getRandomString(10)}";
                                      var id = list_coa.indexWhere((element) => element.nama_akun == akun.text);
                                      var id_amortisasi_akun = list_coa[id].id_amortisasi_akun;
                                      var text_keterangan = keterangan.text;
                                      var jumlahBayar = 0;
                                      var semester = _selectedSemesterInsert;

                                      if (total_harga.text.isNotEmpty) {
                                        jumlahBayar = int.parse(total_harga.text);
                                      }
                                      var jumlahMhs = 0;
                                      if (jumlah_mahasiswa.text.isNotEmpty) {
                                        jumlahMhs = int.parse(jumlah_mahasiswa.text);
                                      }

                                      var tahun_angkatan = 0;
                                      if (thn_angkatan.text.isNotEmpty) {
                                        tahun_angkatan = int.parse(thn_angkatan.text);
                                      }

                                      var penyusutan_per_bulan = (jumlahBayar~/6);

                                      if (id_amortisasi_akun.isNotEmpty && text_keterangan.isNotEmpty &&
                                          jumlahBayar > 0 && jumlahMhs > 0 && penyusutan_per_bulan > 0 && semester.isNotEmpty) {
                                        _pendapatanBloc.add(AmortisasiPendapatanInserted(
                                            pendapatan: AmortisasiPendapatan(
                                                id_pendapatan: id_amortisasi_pendapatan,
                                                id_amortisasi_akun: id_amortisasi_akun,
                                                keterangan: text_keterangan,
                                                jumlah: jumlahBayar,
                                              jumlah_mhs: jumlahMhs,
                                              semester: semester,
                                              penyusutan: penyusutan_per_bulan,
                                              tahun_angkatan: tahun_angkatan
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
                                                  "Amortisasi Pendapatan baru berhasil ditambahkan",
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
                                    _selectedSemesterFilter = newValue;
                                  }
                                });
                              },
                              content: _selectedSemesterFilter,
                              items: semester_filter,
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
                              items: namaAkunListFilter,
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
                        BlocConsumer<AmortisasiPendapatanBloc, SiakState>(
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
                                                "Total (Rp.)",
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
                                                "Jumlah Mahasiswa",
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
                                    source: AmortisasiPendapatanTable(
                                      contentData: list_pendapatan,
                                      seeDetail: (int index) {
                                        setState(() {
                                          _navigateToDetailPendapatan(context, list_pendapatan[index]);
                                        });
                                      },
                                      context: context,
                                    ),
                                    rowsPerPage: int.parse(_selectedEntryFilter),
                                    showCheckboxColumn: false,
                                    horizontalMargin: 0,
                                    columnSpacing: 0,
                                    dataRowHeight: 70,
                                  ),
                                );
                              }
                              return const SizedBox(height: 30, width: 30);
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_pendapatan.clear();
                                list_pendapatan = state.datastore;
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
