import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';
import 'package:sistem_akuntansi/model/response/transaksi_debit_kredit.dart';
import 'package:sistem_akuntansi/model/response/transaksi_model.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:intl/intl.dart';

var list_coa = <Akun>[];

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

  late String _selectedJurnalInsert;
  int id_jurnal = 0;
  String kode_akun = "";

  var tableRow;
  var list_bulan = <VBulanJurnal>[];
  var list_jurnal = <JenisJurnalModel>[];

  void _navigateToJenisJurnal(BuildContext context, int bulan, int tahun){
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
          client: widget.client,
          params: {"bulan": bulan, "tahun": tahun},
        )
      )
    );
  }

  void _navigateSelf(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            SideNavigationBar(
                index: 2,
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

  late VBulanJurnalBloc _bulanBloc;
  late JenisJurnalBloc _jenisJurnalBloc;
  late VJurnalBloc _jurnalBloc;
  late VLookupBloc _coaBloc;

  @override
  void initState() {
    super.initState();
    tableRow = new BulanTahunTableData(
      contentData: const <VBulanJurnal>[],
      seeDetail: (int index) {
        _navigateToJenisJurnal(context, 0, 0);
      },
      context: context,
    );

    _selectedJurnalInsert = "JURNAL PENGELUARAN KAS";
    _bulanBloc = VBulanJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(BulanFetched());
    _jenisJurnalBloc = JenisJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(JenisJurnalFetched(tipe: "UMUM"));
    _jurnalBloc = VJurnalBloc(service: SupabaseService(supabaseClient: widget.client));
    _coaBloc = VLookupBloc(service: SupabaseService(supabaseClient: widget.client))..add(AkunFetched());
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

  List<String> namaAkunDebitList = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];
  List<String> namaAkunKreditList = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];

  List<TextEditingController> akunControllers = <TextEditingController>[];
  List<TextEditingController> akunKreditControllers = <TextEditingController>[];
  List<TextEditingController> jumlahControllers = <TextEditingController>[];
  List<TextEditingController> jumlahKreditControllers = <TextEditingController>[];

  addDynamicDebit(){
    if(akunDebitList.length != 0){
      akunDebitList = [];
      jumlahDebitList = [];
      dynamicDebitList = [];
      akunControllers = [];
      jumlahControllers = [];
    }
    setState(() {});
    if (dynamicDebitList.length >= 10) {
      return;
    }

    akunControllers.add(TextEditingController());
    jumlahControllers.add(TextEditingController());
    dynamicDebitList.add(
      DynamicDebitInsertWidget(
        akunController: akunControllers[akunControllers.length - 1],
        jumlahController: jumlahControllers[jumlahControllers.length - 1],
        namaAkunList: namaAkunDebitList,
      )
    );
  }

  addDynamicKredit(){
    if(akunKreditList.length != 0){
      akunKreditList = [];
      jumlahKreditList = [];
      dynamicKreditList = [];
      akunKreditControllers = [];
      jumlahKreditControllers = [];
    }
    setState(() {});
    if (dynamicKreditList.length >= 10) {
      return;
    }

    akunKreditControllers.add(TextEditingController());
    jumlahKreditControllers.add(TextEditingController());
    dynamicKreditList.add(
      DynamicKreditInsertWidget(
        akunController: akunKreditControllers[akunKreditControllers.length-1],
        jumlahController: jumlahKreditControllers[jumlahKreditControllers.length-1],
        namaAkunList: namaAkunKreditList,
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Jurnal Umum',
      home: Scaffold(
        backgroundColor: background,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _bulanBloc),
            BlocProvider(create: (context) => _jenisJurnalBloc),
            BlocProvider(create: (context) => _coaBloc),
            BlocProvider(create: (context) => _jurnalBloc)
          ],
          child: ListView(
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
                              Expanded(
                                  // width: MediaQuery.of(context).size.width * 0.13,
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
                              Expanded(
                                  // width: MediaQuery.of(context).size.width * 0.20,
                                  child: TextForm(
                                    hintText: "Masukkan nama transaksi",
                                    textController: nama_transaksi,
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              BlocBuilder<JenisJurnalBloc, SiakState>(
                                builder: (_, state) {
                                  if (state is LoadingState || state is FailureState) {
                                    return SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                    );
                                  }
                                  if (state is SuccessState) {
                                    var list_filter = <String>[];
                                    list_jurnal = state.datastore;
                                    for (var jurnal in list_jurnal) { list_filter.add(jurnal.kategori_jurnal); }
                                    print(list_filter);
                                    return Expanded(
                                        // width: MediaQuery.of(context).size.width * 0.3,
                                        child: DropdownForm(
                                          onChanged: (newValue) {
                                            setState(() {
                                              if (newValue != null) {
                                                _selectedJurnalInsert = newValue!!;
                                                var indexItem = list_jurnal.indexWhere((jurnal) => jurnal.kategori_jurnal == _selectedJurnalInsert);
                                                id_jurnal = list_jurnal[indexItem].id_jurnal;
                                              }
                                            });
                                          },
                                          content: _selectedJurnalInsert,
                                          items: list_filter,
                                        )
                                    );
                                  }
                                  return SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.3
                                  );
                                }
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  // width: MediaQuery.of(context).size.width * 0.15,
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
                              mainAxisSize: MainAxisSize.min,
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
                              mainAxisSize: MainAxisSize.min,
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
                                  var tgl_transaksi = tanggal.text;
                                  var nama = nama_transaksi.text;
                                  var id_journal = id_jurnal;
                                  var nomor_bukti = no_bukti.text;
                                  var idTransaksi = "${tgl_transaksi}_${getRandomString(5)}";
                                  
                                  if (tgl_transaksi.isNotEmpty && nama.isNotEmpty && id_journal > 0 && nomor_bukti.isNotEmpty) {
                                    var transaksi = TransaksiModel(
                                      id_transaksi: idTransaksi,
                                        tgl_transaksi: DateFormat('yyyy-MM-dd').parse(tgl_transaksi),
                                        nama_transaksi: nama,
                                        no_bukti: nomor_bukti,
                                        id_jurnal: id_journal
                                    );

                                    var transaksi_dk = <TransaksiDK>[];

                                    for (var i = 0; i < akunControllers.length; i += 1) {
                                      if (akunControllers[i].text.isNotEmpty) {
                                        var indexItem = list_coa.indexWhere((element) => element.nama_akun == akunControllers[i].text);

                                        transaksi_dk.add(
                                            TransaksiDK(
                                                id_transaksi: idTransaksi,
                                                jenis_transaksi: "Debit",
                                                nominal_transaksi: int.parse(jumlahControllers[i].text),
                                              kode_akun: list_coa[indexItem].kode_akun
                                            )
                                        );
                                      }
                                    }

                                    for (var i = 0; i < akunKreditControllers.length; i += 1) {
                                      if (akunKreditControllers[i].text.isNotEmpty) {
                                        var indexItem = list_coa.indexWhere((element) => element.nama_akun == akunKreditControllers[i].text);

                                        transaksi_dk.add(
                                            TransaksiDK(
                                                id_transaksi: idTransaksi,
                                                jenis_transaksi: "Kredit",
                                                nominal_transaksi: int.parse(jumlahKreditControllers[i].text),
                                                kode_akun: list_coa[indexItem].kode_akun
                                            )
                                        );
                                      }
                                    }

                                    // print(transaksi);
                                    _jurnalBloc.add(JurnalInserted(transaksiModel: transaksi, transaksi_dk: transaksi_dk));
                                    
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(Duration(seconds: 2), () {
                                            _navigateSelf(context);
                                            // Navigator.of(context).pop();
                                          });
                                          return DialogNoButton(
                                              content: "Berhasil Ditambahkan!",
                                              content_detail: "Transaksi baru berhasil ditambahkan",
                                              path_image: 'assets/images/tambah_coa.png'
                                          );
                                        }
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Pastikan semua kolom inputan terisi."))
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
                                  var nama_jurnal = textInsert.text;
                                  var tipe_jurnal = "UMUM";
                                  
                                  if (nama_jurnal.isNotEmpty) {
                                    _jenisJurnalBloc.add(JenisJurnalInserted(jenis_jurnal: JenisJurnalModel(kategori_jurnal: nama_jurnal, tipe_jurnal: tipe_jurnal)));
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(Duration(seconds: 2), () {
                                            _navigateSelf(context);
                                          });
                                          return DialogNoButton(
                                              content: "Berhasil Ditambahkan!",
                                              content_detail: "Jenis jurnal baru berhasil ditambahkan",
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
                    BlocConsumer<VBulanJurnalBloc, SiakState>(
                      listener: (_, state) {
                        if (state is SuccessState) {
                          list_bulan.clear();
                          list_bulan = state.datastore;
                        }
                      },
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
                                source: BulanTahunTableData(
                                  contentData: list_bulan,
                                  seeDetail: (int index) {
                                    _navigateToJenisJurnal(context, list_bulan[index].bulan, list_bulan[index].tahun);
                                  },
                                  context: context,
                                ),
                                rowsPerPage: 10,
                                showCheckboxColumn: false,
                              ),
                            );
                          }
                          return const Center(child: Text("No Data"));
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

class DynamicDebitInsertWidget extends StatefulWidget {
  final List<String> namaAkunList;
  final TextEditingController akunController;
  final TextEditingController jumlahController;

  DynamicDebitInsertWidget({
    required this.namaAkunList, required this.akunController, required this.jumlahController
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
    return Flexible( // BAGIAN DEBIT
      // width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
        padding: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: abu_transparan
                  )
              )
          ),
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<VLookupBloc, SiakState>(
                  builder: (_, state) {
                    if (state is SuccessState) {
                      widget.namaAkunList.clear();
                      var filter_akun = List<Akun>.from(state.datastore);
                      list_coa = filter_akun;
                      for (var akun in filter_akun) {
                        if (akun.keterangan_akun.contains("Debit")) {
                          widget.namaAkunList.add(akun.nama_akun);
                        }
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: DropdownSearchButton(
                          isNeedChangeColor: false,
                          notFoundText: 'Akun tidak ditemukan',
                          hintText: 'Pilih akun',
                          controller: widget.akunController,
                          onChange: (String? newValue){
                            setState(() {
                              if(newValue != null) {
                                akunDebitText.text = newValue;
                              }
                            });
                          },
                          items: widget.namaAkunList,
                        ),
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: DropdownSearchButton(
                        isNeedChangeColor: false,
                        notFoundText: 'Akun tidak ditemukan',
                        hintText: 'Pilih akun',
                        controller: widget.akunController,
                        onChange: (String? newValue){
                          setState(() {
                            if(newValue != null) {
                              akunDebitText.text = newValue;
                            }
                          });
                        },
                        items: widget.namaAkunList,
                      ),
                    );
                  },
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: widget.jumlahController,
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
  final TextEditingController akunController;
  final TextEditingController jumlahController;

  DynamicKreditInsertWidget({
    required this.namaAkunList, required this.akunController, required this.jumlahController
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
    return Flexible( // BAGIAN DEBIT
      // width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          child: Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<VLookupBloc, SiakState>(
                builder: (_, state) {
                  if (state is SuccessState) {
                    widget.namaAkunList.clear();
                    var filter_akun = List<Akun>.from(state.datastore);
                    for (var akun in filter_akun) {
                      if (akun.keterangan_akun.contains("Kredit")) {
                        widget.namaAkunList.add(akun.nama_akun);
                      }
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: DropdownSearchButton(
                        isNeedChangeColor: false,
                        notFoundText: 'Akun tidak ditemukan',
                        hintText: 'Pilih akun',
                        controller: widget.akunController,
                        onChange: (String? newValue){
                          setState(() {
                            if(newValue != null) {
                              akunKreditText.text = newValue;
                            }
                          });
                        },
                        items: widget.namaAkunList,
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: DropdownSearchButton(
                      isNeedChangeColor: false,
                      notFoundText: 'Akun tidak ditemukan',
                      hintText: 'Pilih akun',
                      controller: widget.akunController,
                      onChange: (String? newValue){
                        setState(() {
                          if(newValue != null) {
                            akunKreditText.text = newValue;
                          }
                        });
                      },
                      items: widget.namaAkunList,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: widget.jumlahController,
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