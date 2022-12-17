import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_event.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class EditAmortisasiAset extends StatefulWidget {
  const EditAmortisasiAset({required this.client, required this.aset, Key? key}) : super(key: key);

  final SupabaseClient client;
  final AmortisasiAset aset;

  @override
  EditAmortisasiAsetState createState() {
    return EditAmortisasiAsetState();
  }
}

class EditAmortisasiAsetState extends State<EditAmortisasiAset> {
  void _navigateToDetailAset(BuildContext context){
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
              params: {"aset": widget.aset},
            )
    )
    );
  }

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

  @override
  void dispose() {
    super.dispose();
  }

  DateTime? _saat_perolehan;
  //Inisialisasi untuk Dropdown
  late TextEditingController keterangan;
  late TextEditingController nilai_perolehan;
  late TextEditingController masa_guna;
  late TextEditingController akumulasi_penyusutan_tahun_lalu;
  late TextEditingController saat_perolehan;
  late TextEditingController akun;
  late TextEditingController bunga;

  var list_coa = <AmortisasiAkun>[];
  late AmortisasiAsetBloc _asetBloc;
  late AmortisasiAkunBloc _akunBloc;

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

  void initState() {
    super.initState();
    _saat_perolehan = DateTime(widget.aset.tahun_perolehan, listbulan.keys.firstWhere((k) => listbulan[k] == widget.aset.bulan_perolehan, orElse: () => 0));
    keterangan = TextEditingController(text: widget.aset.keterangan);
    nilai_perolehan = TextEditingController(text: widget.aset.nilai_awal.toString());
    masa_guna = TextEditingController(text: widget.aset.masa_guna.toString());
    bunga = TextEditingController(text: widget.aset.persentase_bunga.toString());
    akumulasi_penyusutan_tahun_lalu = TextEditingController(text: widget.aset.akumulasi.toString());
    saat_perolehan = TextEditingController(text: "${listbulan.keys.firstWhere((k) => listbulan[k] == widget.aset.bulan_perolehan, orElse: () => 0)}/${widget.aset.tahun_perolehan}");
    akun = TextEditingController();

    _asetBloc = AmortisasiAsetBloc(service: SupabaseService(supabaseClient: widget.client));
    _akunBloc = AmortisasiAkunBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAkunFetched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Amortisasi Aset',
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
                          content: "Amortisasi Aset", size: 32, color: hitam)),
                  Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: HeaderText(
                              content: "Edit Amortisasi Aset",
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
                                    hintText: "Masukkan nilai perolehan...",
                                    textController: nilai_perolehan,
                                    label: "Rp"),
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
                                    hintText: "Masukkan penyusutan tahun lalu...",
                                    textController:
                                    akumulasi_penyusutan_tahun_lalu,
                                    label: "Rp",
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
                                    var coa = list_coa.firstWhere((element) => element.id_amortisasi_akun == widget.aset.id_amortisasi_akun);
                                    akun.text = coa.nama_akun;
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
                                        onTap: () async {
                                          showMonthPicker(
                                              unselectedMonthTextColor: hitam,
                                              headerColor: kuning,
                                              headerTextColor: hitam,
                                              selectedMonthBackgroundColor:
                                              kuning,
                                              selectedMonthTextColor: hitam,
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
                                            hintText: "Masukkan saat perolehan",
                                            prefixIcon:
                                            Icon(Icons.calendar_today),
                                            contentPadding:
                                            const EdgeInsets.all(5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(8))),
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
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog2Button(
                                            content: "Batalkan Perubahan",
                                            content_detail:
                                            "Anda yakin ingin membatalkan perubahan ini?",
                                            path_image:
                                            'assets/images/berhasil_hapus_coa.png',
                                            button1: "Tetap Simpan",
                                            button2: "Ya, Hapus",
                                            onPressed1: () {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            onPressed2: () {
                                              setState(() {
                                                _navigateToAset(context);
                                              });
                                            });
                                      });
                                },
                                content: "Batal"),
                            SizedBox(width: 20),
                            ButtonNoIcon(
                                bg_color: kuning,
                                text_color: hitam,
                                onPressed: () {
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

                                  var persentase_bunga = 0;
                                  if (bunga.text.isNotEmpty) {
                                    persentase_bunga = int.parse(bunga.text);
                                  }

                                  var penyusutan_sekarang = ((perolehan*persentase_bunga)~/100)~/12;
                                  var tahun = DateTime.now().year;
                                  var saatPerolehan = saat_perolehan.text.split("/");
                                  var bulan_perolehan = "";
                                  bulan_perolehan = listbulan[int.parse(saatPerolehan[0])]!;
                                  var tahun_perolehan = int.parse(saatPerolehan[1]);

                                  if (id_amortisasi_akun.isNotEmpty && text_keterangan.isNotEmpty &&
                                      bulan_perolehan.isNotEmpty && masaGuna > 0 && penyusutan_thn_lalu > 0 && perolehan > 0) {
                                    _asetBloc.add(AmortisasiAsetUpdated(
                                        aset: AmortisasiAset(
                                            id_amortisasi_aset: widget.aset.id_amortisasi_aset,
                                            id_amortisasi_akun: id_amortisasi_akun,
                                            keterangan: text_keterangan,
                                            masa_guna: masaGuna,
                                            nilai_awal: perolehan,
                                            akumulasi: penyusutan_thn_lalu,
                                            penyusutan: penyusutan_sekarang,
                                            tahun: tahun,
                                            tahun_perolehan: tahun_perolehan,
                                            bulan_perolehan: bulan_perolehan
                                        ),
                                      id_amortisasi_aset: widget.aset.id_amortisasi_aset
                                    ));

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(Duration(seconds: 2),
                                                  () {
                                                _navigateToAset(context);
                                              });
                                          return DialogNoButton(
                                              content: "Berhasil Diubah!",
                                              content_detail:
                                              "Amortisasi Aset berhasil diedit",
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
                  )
                ],
              ),
            )));
  }
}
