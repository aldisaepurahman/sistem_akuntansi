import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/Transaksi.dart';
import 'package:intl/intl.dart';

class TransaksiPenyesuaian extends StatefulWidget {
  const TransaksiPenyesuaian({Key? key}) : super(key: key);

  @override
  TransaksiPenyesuaianState createState() {
    return TransaksiPenyesuaianState();
  }
}

class TransaksiPenyesuaianState extends State<TransaksiPenyesuaian> {
  //

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
  List<String> entry = ['5', '10', '25', '50', '100'];

  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];

  bool show = false;
  bool disable_button = false;
  int _case = 1; // 1: insert. 2: update.

  final TextEditingController tanggal = TextEditingController();
  final TextEditingController nama_transaksi = TextEditingController();
  // final TextEditingController no_bukti = TextEditingController();

  final TextEditingController tanggal_update = TextEditingController();
  final TextEditingController nama_transaksi_update = TextEditingController();
  // final TextEditingController no_bukti_update = TextEditingController();

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;

      if (_case == 1) {
        tanggal.text = "";
        nama_transaksi.text = "";
        // no_bukti.text = "";
      } else {
        tanggal_update.text = "";
        nama_transaksi_update.text = "";
        // no_bukti_update.text = "";
        _case = 1; // set lagi ke state awal, yaitu insert
      }
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;

      akunDebitList = [];
      jumlahDebitList = [];
      dynamicDebitList = [];
      akunKreditList = [];
      jumlahKreditList = [];
      dynamicKreditList = [];

      tanggal.text = "";
      nama_transaksi.text = "";
      // no_bukti.text = "";
      tanggal_update.text = "";
      nama_transaksi_update.text = "";
      // no_bukti_update.text = "";
    });
  }

  @override
  void dispose() {
    tanggal.dispose();
    nama_transaksi.dispose();
    // no_bukti.dispose();

    tanggal_update.dispose();
    nama_transaksi_update.dispose();
    // no_bukti_update.dispose();

    super.dispose();
  }

  @override
  void initState() {
    tanggal.text = ""; //set the initial value of text field
    super.initState();
    tableRow = new TransaksiTableData(
      context: context,
      contentData: contents_transaksi,
      seeDetail: () {
        setState(() {
          // navigator
        });
      },
      editForm: () {
        showForm();
      },
      changeCaseToUpdate: () {
        setState(() {
          _case = 2;
        });
      },
    );
  }

  // cara lama yg ga bisa
  // List<Widget> dynamicDebitList = [];
  // Widget akunDebitInput(){
  //   return SizedBox( // BAGIAN DEBIT
  //     width: MediaQuery.of(context).size.width * 0.40,
  //     child: Container(
  //         decoration: BoxDecoration(
  //             border: Border(
  //                 right: BorderSide(
  //                     color: abu_transparan
  //                 )
  //             )
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.25,
  //               child: DropdownSearchButton(
  //                 isNeedChangeColor: false,
  //                 notFoundText: 'Akun tidak ditemukan',
  //                 hintText: 'Pilih akun',
  //                 controller: akun_debit,
  //                 onChange: getAkunDebitText,
  //                 items: namaAkunList,
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.1,
  //               child: TextForm(
  //                 hintText: "Jumlah",
  //                 textController: jumlah_debit,
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             ButtonAdd(
  //                 onPressed: () {
  //                   setState(() {
  //                     dynamicDebitList.add(akunDebitInput());
  //                   });
  //                 }),
  //             SizedBox(
  //               width: 10,
  //             ),
  //           ],
  //         )
  //     ),
  //   );
  // }

  List<DynamicDebitWidget> dynamicDebitList = [];
  List<String> akunDebitList = [];
  List<String> jumlahDebitList = [];

  List<DynamicKreditWidget> dynamicKreditList = [];
  List<String> akunKreditList = [];
  List<String> jumlahKreditList = [];

  addDynamicDebit() {
    if (akunDebitList.length != 0) {
      akunDebitList = [];
      jumlahDebitList = [];
      dynamicDebitList = [];
    }
    setState(() {});
    if (dynamicDebitList.length >= 10) {
      return;
    }
    dynamicDebitList.add(DynamicDebitWidget(
      namaAkunList: namaAkunList,
      formCase: _case,
    ));
  }

  addDynamicKredit() {
    if (akunKreditList.length != 0) {
      akunKreditList = [];
      jumlahKreditList = [];
      dynamicKreditList = [];
    }
    setState(() {});
    if (dynamicKreditList.length >= 10) {
      return;
    }
    dynamicKreditList.add(DynamicKreditWidget(
      namaAkunList: namaAkunList,
      formCase: _case,
    ));
  }

  submitData() {
    // akunDebitList = [];
    // jumlahDebitList = [];
    // dynamicDebitList.forEach((widget) => akunDebitList.add(widget.akunDebitList.text));
    // dynamicDebitList.forEach((widget) => jumlahDebitList.add(widget.jumlahDebitList.text));
    // setState(() {});
    // sendData();
  }

  var tableRow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Transaksi',
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
                              Navigator.pop(context);
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
                      content: "Jurnal Penyesuaian Maret 2022",
                      size: 18,
                      color: hitam),
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
                                      "Tambah Transaksi",
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
                            margin: EdgeInsets.only(bottom: 15),
                            child: HeaderText(
                                content: (_case == 1
                                    ? "Tambah Transaksi"
                                    : "Ubah Transaksi"),
                                size: 18,
                                color: hitam),
                          ),
                          Row(
                              // BARIS PERTAMA FORM
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 20),
                                      child: TextField(
                                        controller: (_case == 1
                                            ? tanggal
                                            : tanggal_update),
                                        style: TextStyle(fontSize: 13),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100));

                                          if (date != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(date);
                                            setState(() {
                                              if (_case == 1) {
                                                tanggal.text = formattedDate;
                                              } else {
                                                tanggal_update.text =
                                                    formattedDate;
                                              }
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                            hintText:
                                                "Masukkan tanggal transaksi",
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            contentPadding:
                                                const EdgeInsets.all(5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Masukkan nama transaksi",
                                      ),
                                      // hintText: "Masukkan nama transaksi",
                                      controller: (_case == 1
                                          ? nama_transaksi
                                          : nama_transaksi_update),
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: HeaderText(
                                            content: "Debit",
                                            size: 16,
                                            color: hitam),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonAdd(onPressed: () {
                                        setState(() {
                                          addDynamicDebit();
                                        });
                                      })
                                    ],
                                  ),
                                  // iterasi dlm sini
                                  for (var i in dynamicDebitList) i,
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 25),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(),
                                          child: HeaderText(
                                              content: "Kredit",
                                              size: 16,
                                              color: hitam),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ButtonAdd(onPressed: () {
                                          setState(() {
                                            addDynamicKredit();
                                          });
                                        })
                                      ],
                                    ),
                                  ),
                                  // iterasi dlm sini
                                  for (var i in dynamicKreditList) i,
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
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
                                  onPressed: submitData,
                                  content: "Simpan")
                            ],
                          )
                        ],
                      ),
                    )),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
                  padding: EdgeInsets.all(25),
                  color: background2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaginatedDataTable(
                        columns: <DataColumn>[
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 20),
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
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 20),
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
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 40),
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
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 20),
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
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 20),
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
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Container(
                              color: Color(int.parse(greyHeaderColor)),
                              padding: EdgeInsets.only(right: 20),
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
                            ),
                          )),
                        ],
                        source: tableRow,
                        rowsPerPage: 10,
                        showCheckboxColumn: false,
                        horizontalMargin: 0,
                        columnSpacing: 0,
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}

class DynamicDebitWidget extends StatefulWidget {
  final List<String> namaAkunList;
  final int formCase;

  DynamicDebitWidget({
    required this.namaAkunList,
    required this.formCase,
  });

  @override
  DynamicDebitWidgetState createState() => DynamicDebitWidgetState();
}

class DynamicDebitWidgetState extends State<DynamicDebitWidget> {
  TextEditingController akunDebitText = new TextEditingController();
  TextEditingController jumlahDebitText = new TextEditingController();

  TextEditingController akunDebitUpdateText = new TextEditingController();
  TextEditingController jumlahDebitUpdateText = new TextEditingController();

  @override
  void dispose() {
    akunDebitText.dispose();
    jumlahDebitText.dispose();
    akunDebitUpdateText.dispose();
    jumlahDebitUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          decoration: BoxDecoration(
              border: Border(right: BorderSide(color: abu_transparan))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DropdownSearchButton(
                  isNeedChangeColor: false,
                  notFoundText: 'Akun tidak ditemukan',
                  hintText: 'Pilih akun',
                  controller: (widget.formCase == 1
                      ? akunDebitText
                      : akunDebitUpdateText),
                  onChange: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        if (widget.formCase == 1) {
                          akunDebitText.text = newValue;
                        } else {
                          akunDebitUpdateText.text = newValue;
                        }
                      }
                    });
                  },
                  items: widget.namaAkunList,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Jumlah",
                  ),
                  // hintText: "Jumlah",
                  controller: (widget.formCase == 1
                      ? jumlahDebitText
                      : jumlahDebitUpdateText),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )),
    );
  }
}

class DynamicKreditWidget extends StatefulWidget {
  final List<String> namaAkunList;
  final int formCase;

  DynamicKreditWidget({
    required this.namaAkunList,
    required this.formCase,
  });

  @override
  DynamicKreditWidgetState createState() => DynamicKreditWidgetState();
}

class DynamicKreditWidgetState extends State<DynamicKreditWidget> {
  TextEditingController akunKreditText = new TextEditingController();
  TextEditingController jumlahKreditText = new TextEditingController();

  TextEditingController akunKreditUpdateText = new TextEditingController();
  TextEditingController jumlahKreditUpdateText = new TextEditingController();

  @override
  void dispose() {
    akunKreditText.dispose();
    jumlahKreditText.dispose();
    akunKreditUpdateText.dispose();
    jumlahKreditUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: DropdownSearchButton(
              isNeedChangeColor: false,
              notFoundText: 'Akun tidak ditemukan',
              hintText: 'Pilih akun',
              controller: (widget.formCase == 1
                  ? akunKreditText
                  : akunKreditUpdateText),
              onChange: (String? newValue) {
                setState(() {
                  if (newValue != null) {
                    if (widget.formCase == 1) {
                      akunKreditText.text = newValue;
                    } else {
                      akunKreditUpdateText.text = newValue;
                    }
                  }
                });
              },
              items: widget.namaAkunList,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextField(
              decoration: InputDecoration(hintText: "Jumlah"),
              // hintText: "Jumlah",
              controller: (widget.formCase == 1
                  ? jumlahKreditText
                  : jumlahKreditUpdateText),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      )),
    );
  }
}

class TransaksiTableData extends DataTableSource {
  Function seeDetail;
  Function editForm;
  BuildContext context;
  final List<Transaksi> _contentData;
  Function changeCaseToUpdate;

  TransaksiTableData({
    required List<Transaksi> contentData,
    required this.context,
    required this.seeDetail,
    required this.editForm,
    required this.changeCaseToUpdate,
  })  : _contentData = contentData,
        assert(contentData != null);

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
              width: MediaQuery.of(context).size.width * 0.1 - 50,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${_content.tanggal}",
                  style: TextStyle(
                    fontFamily: "Inter",
                  ),
                ),
              )),
        ),
        DataCell(SizedBox(
            width: MediaQuery.of(context).size.width * 0.2 - 50,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "${_content.transaksi_debit}",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ))),
        DataCell(SizedBox(
            width: MediaQuery.of(context).size.width * 0.1 - 50,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "Halo2",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ))),
        DataCell(SizedBox(
            width: MediaQuery.of(context).size.width * 0.2 - 50,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40, right: 20),
              child: Text(
                "Halo3",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ))),
        DataCell(SizedBox(
            width: MediaQuery.of(context).size.width * 0.1 - 50,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "Halo4",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
            ))),
        DataCell(SizedBox(
            width: MediaQuery.of(context).size.width * 0.2 - 50,
            child: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.center,
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
                    SizedBox(
                      width: 10,
                    ),
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
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 204, 0),
                        padding: EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        editForm();
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                )))),
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
