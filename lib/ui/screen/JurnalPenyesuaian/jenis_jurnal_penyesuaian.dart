import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class JenisJurnalPenyesuaian extends StatefulWidget {
  const JenisJurnalPenyesuaian({required this.client, required this.bulan, required this.tahun, Key? key}) : super(key: key);

  final SupabaseClient client;
  final int bulan, tahun;

  @override
  JenisJurnalPenyesuaianState createState() {
    return JenisJurnalPenyesuaianState();
  }
}

class JenisJurnalPenyesuaianState extends State<JenisJurnalPenyesuaian> {
  bool show = false;
  bool disable_button = false;
  int _case = 1; // 1: insert. 2: update.
  final textInsert = TextEditingController();
  final textUpdate = TextEditingController();

  var tableRow;
  int id_jurnal = 0;
  List<JenisJurnalModel> list_jurnal = <JenisJurnalModel>[];
  late JenisJurnalModel jurnal;
  late JenisJurnalBloc _jenisJurnalBloc;

  void _navigateToDaftarTransaksiPenyesuaian(BuildContext context, int id_jurnal) {
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
            params: {"bulan": widget.bulan, "tahun": widget.tahun, "id_jurnal": id_jurnal}
        )
    )
    );
  }

  void _navigateToJenisJurnal(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 7,
          coaIndex: 0,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          labaRugiIndex: 0,
          neracaLajurIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 1,
          client: widget.client,
          params: {"bulan": widget.bulan, "tahun": widget.tahun},
        )
      )
    );
  }

  void _navigateToJurnalPenyesuaian(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SideNavigationBar(
          index: 7,
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
    textInsert.dispose();
    textUpdate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tableRow = new JenisJurnalTableData(
      contentData: const <JenisJurnalModel>[],
      seeDetail: (int index){
        _navigateToDaftarTransaksiPenyesuaian(context, 0);
      },
      editForm: (int index) {
        showForm();
      },
      tetapSimpan: (){
        setState(() {
          Navigator.pop(context);
        });
      },
      hapus: (int index){
        _navigateToJenisJurnal(context);
      },
      context: context,
      changeCaseToUpdate: (){
        setState(() {
          _case = 2;
        });
      },
    );

    _jenisJurnalBloc = JenisJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(JenisJurnalFetched(tipe: "PENYESUAIAN"));
    jurnal = JenisJurnalModel();
  }

  void showForm() {
    setState(() {
      disable_button = true;
      show = true;
      if(_case == 1) {
        textInsert.text = "";
      }
      else {
        textUpdate.text = jurnal.kategori_jurnal;
        _case = 1; // set lagi ke state awal, yaitu insert
      }
    });
  }

  void disableForm() {
    setState(() {
      textInsert.text = "";
      textUpdate.text = "";
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
        title: 'List Jurnal Umum',
        home: Scaffold(
            backgroundColor: background,
            body: BlocProvider<JenisJurnalBloc>(
              create: (context) => _jenisJurnalBloc,
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
                              _navigateToJurnalPenyesuaian(context);
                            },
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(
                        content: "Jenis Jurnal",
                        size: 32,
                        color: hitam,
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 15, left: 25),
                      child: HeaderText(
                        content: "Jurnal Penyesuaian - Maret 2022",
                        size: 18,
                        color: hitam,
                      )
                  ),
                  Container(
                      width: 30,
                      margin: EdgeInsets.only(left: 25, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kuning,
                                  padding: const EdgeInsets.all(18)),
                              onPressed: (disable_button == true ? null : showForm),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        "Tambah Jenis Jurnal",
                                        style: TextStyle(
                                          fontFamily: "Inter",
                                          color: hitam,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                          )
                        ],
                      )
                  ),
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
                                  content: (_case == 1 ? "Tambah Jenis Jurnal" : "Ubah Jenis Jurnal"),
                                  size: 18,
                                  color: hitam),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.50,
                                      child: TextForm(
                                        hintText: "Masukkan jenis jurnal",
                                        textController: (_case == 1 ? textInsert : textUpdate),
                                      )
                                  ),
                                ]
                            ),
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
                                      var nama_jurnal = _case == 1 ? textInsert.text : textUpdate.text;
                                      var tipe_jurnal = "PENYESUAIAN";

                                      if (nama_jurnal.isNotEmpty) {
                                        _case == 1
                                            ? _jenisJurnalBloc.add(JenisJurnalInserted(jenis_jurnal: JenisJurnalModel(kategori_jurnal: nama_jurnal, tipe_jurnal: tipe_jurnal)))
                                            : _jenisJurnalBloc.add(JenisJurnalUpdated(jenis_jurnal: JenisJurnalModel(kategori_jurnal: nama_jurnal, tipe_jurnal: tipe_jurnal), id_jurnal: jurnal.id_jurnal));
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(Duration(seconds: 2), () {
                                                _navigateToJenisJurnal(context);
                                              });
                                              return DialogNoButton(
                                                  content: _case == 1 ? "Berhasil Ditambahkan!" : "Berhasil Diubah!",
                                                  content_detail: (_case == 1 ? "Jenis jurnal baru berhasil ditambahkan" : "Jenis jurnal berhasil diubah"),
                                                  path_image: 'assets/images/tambah_coa.png'
                                              );
                                            }
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Pastikan nama jurnal terisi."))
                                        );
                                      }
                                    },
                                    content: "Simpan"
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocConsumer<JenisJurnalBloc, SiakState>(
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
                                                "Jenis Jurnal",
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
                                    source: JenisJurnalTableData(
                                      contentData: list_jurnal,
                                      seeDetail: (int index){
                                        _navigateToDaftarTransaksiPenyesuaian(context, list_jurnal[index].id_jurnal);
                                      },
                                      editForm: (int index) {
                                        jurnal.id_jurnal = list_jurnal[index].id_jurnal;
                                        jurnal.kategori_jurnal = list_jurnal[index].kategori_jurnal;
                                        jurnal.tipe_jurnal = list_jurnal[index].tipe_jurnal;

                                        showForm();
                                      },
                                      tetapSimpan: (){
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      hapus: (int index){
                                        _jenisJurnalBloc.add(JenisJurnalDeleted(id_jurnal: list_jurnal[index].id_jurnal));
                                        Future.delayed(Duration(seconds: 2), () {
                                          _navigateToJenisJurnal(context);
                                        });
                                      },
                                      context: context,
                                      changeCaseToUpdate: (){
                                        setState(() {
                                          _case = 2;
                                        });
                                      },
                                    ),
                                    rowsPerPage: 10,
                                    showCheckboxColumn: false,
                                    dataRowHeight: 70,
                                    horizontalMargin: 0,
                                    columnSpacing: 0,
                                  ),
                                );
                              }
                              return const Center(child: Text("No Data"));
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_jurnal.clear();
                                list_jurnal = state.datastore;
                              }
                            },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}

class JenisJurnalTableData extends DataTableSource {
  Function(int) seeDetail;
  Function(int) editForm;
  Function tetapSimpan;
  Function(int) hapus;
  BuildContext context;
  final List<JenisJurnalModel> _contentData;
  Function changeCaseToUpdate;

  JenisJurnalTableData({
    required List<JenisJurnalModel> contentData,
    required this.context,
    required this.seeDetail,
    required this.editForm,
    required this.tetapSimpan,
    required this.hapus,
    required this.changeCaseToUpdate,
  })
      : _contentData = contentData, assert(contentData != null);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _contentData.length) {
      return null;
    }
    final _content = _contentData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.kategori_jurnal}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(
            SizedBox(
                width: double.infinity,
                child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            seeDetail(index);
                          },
                          child: Icon(Icons.remove_red_eye),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            editForm(index);
                            changeCaseToUpdate();
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog2Button(
                                      content: "Hapus Jenis Jurnal",
                                      content_detail:
                                      "Anda yakin ingin menghapus data ini?",
                                      path_image: 'assets/images/hapus_coa.png',
                                      button1: "Tetap Simpan",
                                      button2: "Ya, Hapus",
                                      onPressed1: () {
                                        tetapSimpan();
                                      },
                                      onPressed2: () {
                                        hapus(index);
                                      }
                                  );
                                }
                            );
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    )
                )
            )
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _contentData.length;

  @override
  int get selectedRowCount => 0;
}