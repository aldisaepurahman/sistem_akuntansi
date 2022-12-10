import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/utils/Jenis_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class JenisJurnal extends StatefulWidget {
  const JenisJurnal({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  JenisJurnalState createState() {
    return JenisJurnalState();
  }
}

class JenisJurnalState extends State<JenisJurnal> {
  bool show = false;
  bool disable_button = false;
  int _case = 1; // 1: insert. 2: update.
  final textInsert = TextEditingController();
  final textUpdate = TextEditingController();

  var tableRow;

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
      contentData: contents,
      seeDetail: (){
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
              SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 2, bukuBesarIndex: 0, client: widget.client)));
        });
      },
      editForm: () {
        showForm();
      },
      tetapSimpan: (){
        setState(() {
          Navigator.pop(context);
        });
      },
      hapus: (){
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
              SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 1, bukuBesarIndex: 0, client: widget.client)));
        });
      },
      context: context,
      changeCaseToUpdate: (){
        setState(() {
          _case = 2;
        });
      },
    );
  }

  void showForm() {
    setState(() {
      disable_button = true;
      show = true;
      if(_case == 1) {
        textInsert.text = "";
      }
      else {
        textUpdate.text = "";
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
            body: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ButtonBack(
                          onPressed: (){
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                  SideNavigationBar(index: 2, coaIndex: 0, jurnalUmumIndex: 0, bukuBesarIndex: 0, client: widget.client)));
                            });
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
                    content: "Jurnal Umum - Maret 2022",
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
                                  setState(() {});
                                },
                                content: "Simpan")
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
                      Container(
                        width: double.infinity,
                        child: PaginatedDataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text("No."),
                            ),
                            DataColumn(
                              label: Text("Jenis Jurnal"),
                            ),
                            DataColumn(
                              label: Text("Action"),
                            ),
                          ],
                          source: tableRow,
                          rowsPerPage: 10,
                          showCheckboxColumn: false,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}

class JenisJurnalTableData extends DataTableSource {
  Function seeDetail;
  Function editForm;
  Function tetapSimpan;
  Function hapus;
  BuildContext context;
  final List<Jenis_jurnal> _contentData;
  Function changeCaseToUpdate;

  JenisJurnalTableData({
    required List<Jenis_jurnal> contentData,
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
        DataCell(
          SizedBox(
              width: MediaQuery.of(context).size.width / 10 - 50,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${index+1}",
                  style: TextStyle(
                    fontFamily: "Inter",
                  ),
                ),
              )
          ),
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 50,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${_content.nama_jurnal}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                )
            )
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width / 5 - 50,
                child: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            seeDetail();
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
                            editForm();
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
                                    hapus();
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