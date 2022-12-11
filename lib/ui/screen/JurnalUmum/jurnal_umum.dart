import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:intl/intl.dart';

class JurnalUmumList extends StatefulWidget {
  const JurnalUmumList({required this.client, Key? key}) : super(key: key);

  final SupabaseClient client;

  @override
  JurnalUmumListState createState() {
    return JurnalUmumListState();
  }
}

class JurnalUmumListState extends State<JurnalUmumList> {
  bool show = false;
  bool disable_button = false;
  bool show2 = false;
  bool disable_button2 = false;

  final TextEditingController tanggal = TextEditingController();
  final TextEditingController nama_transaksi = TextEditingController();
  final TextEditingController no_bukti = TextEditingController();
  final TextEditingController textInsert = TextEditingController();

  @override
  void dispose(){
    tanggal.dispose();
    nama_transaksi.dispose();
    no_bukti.dispose();
    textInsert.dispose();
    super.dispose();
  }

  String _selectedJurnalInsert = "JURNAL PENGELUARAN KAS";

  var tableRow;

  void _navigateToJenisJurnal(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 2,
          coaIndex: 0,
          jurnalUmumIndex: 1,
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
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: contents,
      seeDetail: () {
        _navigateToJenisJurnal(context);
      },
      context: context,
    );
  }

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;
      disable_button2 = true;

      tanggal.text = "";
      nama_transaksi.text = "";
      no_bukti.text = "";
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;
      disable_button2 = false;

      akunDebitList = [];
      jumlahDebitList = [];
      dynamicDebitList = [];
      akunKreditList = [];
      jumlahKreditList = [];
      dynamicKreditList = [];

      tanggal.text = "";
      nama_transaksi.text = "";
      no_bukti.text = "";
    });
  }

  void showForm2() {
    setState(() {
      show2 = true;
      disable_button = true;
      disable_button2 = true;

      textInsert.text = "";
    });
  }

  void disableForm2() {
    setState(() {
      textInsert.text = "";

      show2 = false;
      disable_button = false;
      disable_button2 = false;
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

  List<String> jurnal = [
    "JURNAL PENGELUARAN KAS",
    "JURNAL PENERIMAAN KAS",
    "JURNAL PENGELUARAN BANK OCBC NISP",
    "JURNAL PENERIMAAN BANK OCBC NISP",
    "JURNAL PENGELUARAN BRI STIKES SANTO BORROMEUS",
    "JURNAL PENERIMAAN BRI STIKES SANTO BORROMEUS",
    "JURNAL PENGELUARAN TABUNGAN BRITAMA",
    "JURNAL PENERIMAAN TABUNGAN BRITAMA",
    "JURNAL PENGELUARAN BRI BRIVA",
    "JURNAL PENERIMAAN BRI BRIVA",
    "JURNAL TABUNGAN BNI",
    "JURNAL GAJI"
  ];

  List<DynamicDebitInsertWidget> dynamicDebitList = [];
  List<String> akunDebitList = [];
  List<String> jumlahDebitList = [];

  List<DynamicKreditInsertWidget> dynamicKreditList = [];
  List<String> akunKreditList = [];
  List<String> jumlahKreditList = [];

  List<String> namaAkunList = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];

  addDynamicDebit(){
    if(akunDebitList.length != 0){
      akunDebitList = [];
      jumlahDebitList = [];
      dynamicDebitList = [];
    }
    setState(() {});
    if (dynamicDebitList.length >= 10) {
      return;
    }
    dynamicDebitList.add(
      DynamicDebitInsertWidget(
        namaAkunList: namaAkunList,
      )
    );
  }

  addDynamicKredit(){
    if(akunKreditList.length != 0){
      akunKreditList = [];
      jumlahKreditList = [];
      dynamicKreditList = [];
    }
    setState(() {});
    if (dynamicKreditList.length >= 10) {
      return;
    }
    dynamicKreditList.add(
      DynamicKreditInsertWidget(
        namaAkunList: namaAkunList,
      )
    );
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
              margin: EdgeInsets.only(top: 25, left: 25),
              child: HeaderText(
                  content: "Jurnal Umum", size: 32, color: hitam
              )
            ),
            Container(
              width: 30,
              margin: EdgeInsets.only(left: 25, top: 10),
              child: Row(
                children: [
                  Row(
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
                          )
                      )
                    ],
                  ),
                  SizedBox(width: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kuning,
                              padding: const EdgeInsets.all(18)),
                          onPressed: (disable_button2 ? null : showForm2),
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
                        margin: EdgeInsets.only(bottom: 15),
                        child: HeaderText(
                            content: "Tambah Transaksi",
                            size: 18,
                            color: hitam),
                      ),
                      Row( // BARIS PERTAMA FORM
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.13,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 20),
                                  child: TextField(
                                    controller: tanggal,
                                    style: TextStyle(fontSize: 13),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100)
                                      );

                                      if (date != null) {
                                        String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(date);
                                        setState(() {
                                            tanggal.text = formattedDate;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Masukkan tanggal transaksi",
                                        prefixIcon: Icon(Icons.calendar_today),
                                        contentPadding: const EdgeInsets.all(5),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8)
                                        )
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: TextForm(
                                  hintText: "Masukkan nama transaksi",
                                  textController: nama_transaksi,
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: DropdownForm(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      if (newValue != null) {
                                        _selectedJurnalInsert = newValue!;
                                      }
                                    });
                                  },
                                  content: _selectedJurnalInsert,
                                  items: jurnal,
                                )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: TextForm(
                                  hintText: "Masukkan no. bukti",
                                  textController: no_bukti,
                                )
                            ),
                          ]
                      ),
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
                                        color: hitam
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ButtonAdd(
                                      onPressed: (){
                                        setState(() {
                                          addDynamicDebit();
                                        });
                                      }
                                  )
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
                                          color: hitam
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ButtonAdd(
                                        onPressed: (){
                                          setState(() {
                                            addDynamicKredit();
                                          });
                                        }
                                    )
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
                              content: "Batal"
                          ),
                          SizedBox(width: 20),
                          ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return DialogNoButton(
                                          content: "Berhasil Ditambahkan!",
                                          content_detail: "Transaksi baru berhasil ditambahkan",
                                          path_image: 'assets/images/tambah_coa.png'
                                      );
                                    }
                                );
                              },
                              content: "Simpan"
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),
            Visibility(
                visible: show2,
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
                            content: "Tambah Jenis Jurnal",
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
                                  textController: textInsert,
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
                              onPressed: disableForm2,
                              content: "Batal"),
                          SizedBox(width: 20),
                          ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return DialogNoButton(
                                          content: "Berhasil Ditambahkan!",
                                          content_detail: "Jenis jurnal baru berhasil ditambahkan",
                                          path_image: 'assets/images/tambah_coa.png'
                                      );
                                    }
                                );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DropdownFilter(
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue != null) {
                              _selectedMonthFilter = newValue;
                            }
                          });
                        },
                        content: _selectedMonthFilter,
                        items: month,
                      ),
                      SizedBox(width: 20),
                      DropdownFilter(
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
                    ],
                  ),
                  SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text("No."),
                        ),
                        DataColumn(
                          label: Text("Bulan"),
                        ),
                        DataColumn(
                          label: Text("Tahun"),
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

class DynamicDebitInsertWidget extends StatefulWidget {
  final List<String> namaAkunList;

  DynamicDebitInsertWidget({
    required this.namaAkunList,
  });

  @override
  DynamicDebitInsertWidgetState createState() => DynamicDebitInsertWidgetState();
}

class DynamicDebitInsertWidgetState extends State<DynamicDebitInsertWidget> {
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
    return SizedBox( // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: abu_transparan
                  )
              )
          ),
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
                  controller: akunDebitText,
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        akunDebitText.text = newValue;
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
                child: TextForm(
                  hintText: "Jumlah",
                  textController: jumlahDebitText,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}

class DynamicKreditInsertWidget extends StatefulWidget {
  final List<String> namaAkunList;

  DynamicKreditInsertWidget({
    required this.namaAkunList,
  });

  @override
  DynamicKreditInsertWidgetState createState() => DynamicKreditInsertWidgetState();
}

class DynamicKreditInsertWidgetState extends State<DynamicKreditInsertWidget> {
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
    return SizedBox( // BAGIAN DEBIT
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
                  controller: akunKreditText,
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        akunKreditText.text = newValue;
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
                child: TextForm(
                  hintText: "Jumlah",
                  textController: jumlahKreditText,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}