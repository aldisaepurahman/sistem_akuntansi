import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_bloc.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';
import 'package:sistem_akuntansi/model/response/transaksi_debit_kredit.dart';
import 'package:sistem_akuntansi/model/response/transaksi_model.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/utils/Transaksi.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/ui/components/dynamic_input.dart';

var list_coa = <Akun>[];

class TransaksiPenyesuaianList extends StatefulWidget {
  final SupabaseClient client;
  final int bulan, tahun, id_jurnal;

  const TransaksiPenyesuaianList({required this.client, required this.bulan, required this.tahun, required this.id_jurnal, Key? key}) : super(key: key);

  @override
  TransaksiPenyesuaianListState createState() {
    return TransaksiPenyesuaianListState();
  }
}

class TransaksiPenyesuaianListState extends State<TransaksiPenyesuaianList> {
  String _selectedJurnalInsert = "JURNAL GAJI";
  String _selectedJurnalUpdate = "JURNAL GAJI"; // read dari database
  String _selectedJurnalFilter = "JURNAL PENGELUARAN KAS";

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

  List<String> namaAkunList = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];
  List<String> namaAkunKreditList = ['Beban Kesekretariatan', 'Beban ART', 'Uang Tunai (Bendahara)', 'Rekening Giro Bank NISP'];

  bool show = false;
  bool disable_button = false;
  int _case = 1; // 1: insert. 2: update.

  final TextEditingController tanggal = TextEditingController();
  final TextEditingController nama_transaksi = TextEditingController();
  late TextEditingController no_bukti;

  final TextEditingController tanggal_update = TextEditingController();
  final TextEditingController nama_transaksi_update = TextEditingController();
  late TextEditingController no_bukti_update;

  late VJurnalBloc _jurnalBloc;
  late VLookupBloc _coaBloc;
  late JenisJurnalBloc _jenisJurnalBloc;
  var list_transaksi = <String, List<VJurnalExpand>>{};
  var split_key_transaksi = <List<String>>[];
  var temp_list_transaksi = <VJurnalExpand>[];
  var list_jurnal = <JenisJurnalModel>[];
  int id_jurnal = 0;

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;

      if(_case == 1) {
        tanggal.text = "";
        nama_transaksi.text = "";
        no_bukti.text = "";
      }
      else {
        tanggal_update.text = "";
        nama_transaksi_update.text = "";
        no_bukti_update.text = "";
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
      no_bukti.text = "";
      tanggal_update.text = "";
      nama_transaksi_update.text = "";
      no_bukti_update.text = "";
    });
  }

  void _navigateToDaftarTransaksi(BuildContext context) {
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
                jurnalPenyesuaianIndex: 2,
                client: widget.client,
              params: {"bulan": widget.bulan, "tahun": widget.tahun, "id_jurnal": widget.id_jurnal},
            )
        )
    );
  }

  void _navigateToDetailTransaksi(BuildContext context, Map<String, List<VJurnalExpand>> params) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 7,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 0,
              jurnalPenyesuaianIndex: 3,
              client: widget.client,
                params: {"bulan": widget.bulan, "tahun": widget.tahun, "id_jurnal": widget.id_jurnal, "transaksi": params}
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
                params: {"bulan": widget.bulan, "tahun": widget.tahun}
            )
        )
    );
  }

  @override
  void dispose() {
    tanggal.dispose();
    nama_transaksi.dispose();
    no_bukti.dispose();

    tanggal_update.dispose();
    nama_transaksi_update.dispose();
    no_bukti_update.dispose();

    super.dispose();
  }

  @override
  void initState() {
    tanggal.text = ""; //set the initial value of text field
    tanggal_update.text = "";

    super.initState();

    tableRow = new TransaksiTableData(
      context: context,
      contentData: <String, List<VJurnalExpand>>{},
      seeDetail: (index){
        _navigateToDetailTransaksi(context, {});
      },
      editForm: (index){
        showForm();
      },
      tetapSimpan: (){
        setState(() {
          Navigator.pop(context);
        });
      },
      hapus: (index){
        _navigateToDaftarTransaksi(context);
      },
      changeCaseToUpdate: (){
        setState(() {
          _case = 2;
        });
      },
    );

    no_bukti = TextEditingController(text: "AJP");
    no_bukti_update = TextEditingController(text: "AJP");
    _jurnalBloc = VJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(
        JurnalFetched(bulan: widget.bulan, tahun: widget.tahun, id_jurnal: widget.id_jurnal));
    _coaBloc = VLookupBloc(service: SupabaseService(supabaseClient: widget.client))..add(AkunFetched());
    _jenisJurnalBloc = JenisJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(JenisJurnalFetched(tipe: "PENYESUAIAN"));
  }

  List<DynamicDebitInsertWidget> dynamicDebitList = [];
  List<String> akunDebitList = [];
  List<String> jumlahDebitList = [];

  List<DynamicKreditInsertWidget> dynamicKreditList = [];
  List<String> akunKreditList = [];
  List<String> jumlahKreditList = [];

  List<TextEditingController> akunControllers = <TextEditingController>[];
  List<TextEditingController> akunKreditControllers = <TextEditingController>[];
  List<TextEditingController> jumlahControllers = <TextEditingController>[];
  List<TextEditingController> jumlahKreditControllers = <TextEditingController>[];

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
    akunControllers.add(TextEditingController());
    jumlahControllers.add(TextEditingController());

    dynamicDebitList.add(
        DynamicDebitInsertWidget(
            namaAkunList: namaAkunList,
            akunController: akunControllers[akunControllers.length - 1],
            jumlahController: jumlahControllers[jumlahControllers.length - 1]
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
            body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => _jurnalBloc),
                BlocProvider(create: (context) => _jenisJurnalBloc),
                BlocProvider(create: (context) => _coaBloc),
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
                              _navigateToJenisJurnal(context);
                            },
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: HeaderText(content: "Daftar Transaksi", size: 32, color: hitam)
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, left: 25),
                    child: HeaderText(
                        content: "Jurnal Maret 2022", size: 18, color: hitam
                    ),
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
                              margin: EdgeInsets.only(bottom: 15),
                              child: HeaderText(
                                  content: (_case == 1 ? "Tambah Transaksi" : "Ubah Transaksi"),
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
                                          controller: (_case == 1 ? tanggal : tanggal_update),
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
                                                if(_case == 1) {
                                                  tanggal.text = formattedDate;
                                                }
                                                else {
                                                  tanggal_update.text = formattedDate;
                                                }
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
                                        textController: (_case == 1 ? nama_transaksi : nama_transaksi_update),
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
                                                      var indexItem = 0;
                                                      if (_case == 1) {
                                                        _selectedJurnalInsert = newValue!;
                                                        indexItem = list_jurnal.indexWhere((jurnal) => jurnal.kategori_jurnal == _selectedJurnalInsert);
                                                      }
                                                      else {
                                                        _selectedJurnalUpdate = newValue!;
                                                        indexItem = list_jurnal.indexWhere((jurnal) => jurnal.kategori_jurnal == _selectedJurnalUpdate);
                                                      }

                                                      id_jurnal = list_jurnal[indexItem].id_jurnal;
                                                    }
                                                  });
                                                },
                                                content: (_case == 1 ? _selectedJurnalInsert : _selectedJurnalUpdate),
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
                                  /*Expanded(
                                    // width: MediaQuery.of(context).size.width * 0.15,
                                      child: TextForm(
                                        readonly: true,
                                        hintText: "Masukkan no. bukti",
                                        textController: (_case == 1 ? no_bukti : no_bukti_update),
                                      )
                                  ),*/
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
                                      var tgl_transaksi = (_case == 1 ? tanggal.text : tanggal_update.text);
                                      var nama = (_case == 1 ? nama_transaksi.text : nama_transaksi_update.text);
                                      var id_journal = id_jurnal;
                                      var nomor_bukti = "AJP";
                                      var idTransaksi = "${tgl_transaksi}_${getRandomString(5)}";

                                      if (tgl_transaksi.isNotEmpty && nama.isNotEmpty && id_journal > 0) {
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

                                        _jurnalBloc.add(JurnalInserted(transaksiModel: transaksi, transaksi_dk: transaksi_dk));

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(Duration(seconds: 2), () {
                                                _navigateToDaftarTransaksi(context);
                                                // Navigator.of(context).pop();
                                              });
                                              return DialogNoButton(
                                                  content: (_case == 1 ? "Berhasil Ditambahkan!" : "Berhasil Diubah!"),
                                                  content_detail: (_case == 1 ? "Transaksi baru berhasil ditambahkan" : "Transaksi berhasil diubah"),
                                                  path_image: 'assets/images/tambah_coa.png');
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
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 50, right: 25, left: 25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocConsumer<VJurnalBloc, SiakState>(
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
                                          )
                                      ),
                                      DataColumn(
                                          label: Expanded(
                                            child: Container(
                                              color: greyHeaderColor,
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
                                          )
                                      ),
                                      DataColumn(
                                          label: Expanded(
                                            child: Container(
                                              color: greyHeaderColor,
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
                                          )
                                      ),
                                      DataColumn(
                                          label: Expanded(
                                            child: Container(
                                              color: greyHeaderColor,
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
                                          )
                                      ),
                                      DataColumn(
                                          label: Expanded(
                                            child: Container(
                                              color: greyHeaderColor,
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
                                          )
                                      ),
                                      DataColumn(
                                          label: Expanded(
                                            child: Container(
                                              color: greyHeaderColor,
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
                                          )
                                      ),
                                    ],
                                    source: TransaksiTableData(
                                      context: context,
                                      contentData: list_transaksi,
                                      seeDetail: (index){
                                        Map<String, List<VJurnalExpand>> params = {};
                                        var kunci = list_transaksi.keys.elementAt(index);
                                        var lists = list_transaksi.values.elementAt(index);

                                        params[kunci] = lists;

                                        _navigateToDetailTransaksi(context, params);
                                      },
                                      editForm: (index){
                                        showForm();
                                      },
                                      tetapSimpan: (){
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      hapus: (index){
                                        var lists = list_transaksi.values.elementAt(index);

                                        _jurnalBloc.add(JurnalDeleted(id_transaksi: lists[0].id_transaksi));
                                        Future.delayed(Duration(seconds: 2), () {
                                          _navigateToDaftarTransaksi(context);
                                        });
                                      },
                                      changeCaseToUpdate: (){
                                        setState(() {
                                          _case = 2;
                                        });
                                      },
                                    ),
                                    rowsPerPage: 10,
                                    showCheckboxColumn: false,
                                    horizontalMargin: 0,
                                    columnSpacing: 0,
                                    dataRowHeight: 150,
                                  ),
                                );
                              }
                              return const Center(child: Text("No Data"));
                            },
                            listener: (_, state) {
                              if (state is SuccessState) {
                                list_transaksi.clear();
                                temp_list_transaksi.clear();
                                temp_list_transaksi = state.datastore;
                                list_transaksi = mappings(temp_list_transaksi.where((element) => element.no_bukti.contains("AJP")).toList());
                                list_transaksi.forEach((key, value) {
                                  split_key_transaksi.add(List<String>.from(key.split("+")));
                                });
                              }
                            },
                        )
                      ],
                    ),
                  ),
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

class TransaksiTableData extends DataTableSource {
  Function(int) seeDetail;
  Function(int) editForm;
  Function tetapSimpan;
  Function(int) hapus;
  BuildContext context;
  final Map<String, List<VJurnalExpand>> _contentData;
  Function changeCaseToUpdate;

  TransaksiTableData({
    required Map<String, List<VJurnalExpand>> contentData,
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
    final listContent = <List<VJurnalExpand>>[];
    final splitContent = [];

    _contentData.forEach((key, value) {
      listContent.add(value);
      splitContent.add(key.split("+"));
    });

    final _content = listContent[index];
    final _debitContent = _content.where((element) => element.jenis_transaksi == "Debit").toList();
    final _kreditContent = _content.where((element) => element.jenis_transaksi == "Kredit").toList();

    int totalDebit = _debitContent.length;
    int totalKredit = _kreditContent.length;

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.1 - 50,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      DateFormat('dd/MM').format(DateTime.parse(splitContent[index][2])),
                      style: TextStyle(
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                )
              )
          ),
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5 - 50,
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < totalDebit; i++)
                          Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "${_debitContent[i].nama_akun}",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                ),
                              ),
                            ],
                          )
                      ],
                    )
                )
            )
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1 - 50,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      for (int i = 0; i < totalDebit; i++)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "${_debitContent[i].nominal_transaksi}",
                              style: TextStyle(
                                fontFamily: "Inter",
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                )
            )
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5 - 50,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 40, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < totalKredit; i++)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "${_kreditContent[i].nama_akun}",
                              style: TextStyle(
                                fontFamily: "Inter",
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                )
            )
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.1 - 50,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: [
                      for (int i = 0; i < totalKredit; i++)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              "${_kreditContent[i].nominal_transaksi}",
                              style: TextStyle(
                                fontFamily: "Inter",
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                )
            )
        ),
        DataCell(
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2 - 50,
                child: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
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
                            /*SizedBox(width: 10,),
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
                            ),*/
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
                                        content: "Hapus Transaksi",
                                        content_detail: "Anda yakin ingin menghapus data ini?",
                                        path_image: 'assets/images/hapus_coa.png',
                                        button1: "Tetap Simpan",
                                        button2: "Ya, Hapus",
                                        onPressed1: () {
                                          tetapSimpan();
                                        },
                                        onPressed2: () {
                                          hapus(index);
                                        },
                                      );
                                    }
                                );
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        )
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