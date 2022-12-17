import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

class EditAmortisasiPendapatan extends StatefulWidget {
  const EditAmortisasiPendapatan({required this.client, required this.pendapatan, Key? key})
      : super(key: key);

  final SupabaseClient client;
  final AmortisasiPendapatan pendapatan;

  @override
  EditAmortisasiPendapatanState createState() {
    return EditAmortisasiPendapatanState();
  }
}

class EditAmortisasiPendapatanState extends State<EditAmortisasiPendapatan> {
  void _navigateToDetailPendapatan(BuildContext context){
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
              params: {"pendapatan": widget.pendapatan},
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

  @override
  void dispose() {
    super.dispose();
  }

  //Inisialisasi untuk Dropdown
  late TextEditingController keterangan;
  late TextEditingController total_harga;
  late TextEditingController jumlah_mahasiswa;
  late TextEditingController akun;
  late TextEditingController thn_angkatan;

  var list_coa = <AmortisasiAkun>[];
  late AmortisasiPendapatanBloc _pendapatanBloc;
  late AmortisasiAkunBloc _akunBloc;

  String _selectedSemesterInsert = 'Ganjil';
  String _selectedAkunInsert = '2022';

  @override
  void initState() {
    super.initState();

    _pendapatanBloc = AmortisasiPendapatanBloc(service: SupabaseService(supabaseClient: widget.client));
    _akunBloc = AmortisasiAkunBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAkunFetched());

    keterangan = TextEditingController(text: widget.pendapatan.keterangan);
    total_harga = TextEditingController(text: widget.pendapatan.jumlah.toString());
    jumlah_mahasiswa = TextEditingController(text: widget.pendapatan.jumlah_mhs.toString());
    akun = TextEditingController();
    thn_angkatan = TextEditingController(text: widget.pendapatan.tahun_angkatan.toString());
    _selectedSemesterInsert = widget.pendapatan.semester;
  }

  List<String> semester = ['Ganjil', 'Genap'];
  List<String> namaAkunList = [
    'Beban Kesekretariatan',
    'Beban ART',
    'Uang Tunai (Bendahara)',
    'Rekening Giro Bank NISP'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Amortisasi Pendapatan',
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
                                Navigator.pop(context);
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
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: HeaderText(
                              content: "Edit Amortisasi Pendapatan",
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
                                      textController: total_harga)),
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
                                      hintText: "Masukkan jumlah mahasiswa...",
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
                                    var coa = list_coa.firstWhere((element) => element.id_amortisasi_akun == widget.pendapatan.id_amortisasi_akun);
                                    akun.text = coa.nama_akun;
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
                                                _navigateToPendapatan(context);
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
                                  var id_amortisasi_pendapatan = widget.pendapatan.id_pendapatan;
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
                                    _pendapatanBloc.add(AmortisasiPendapatanUpdated(
                                        pendapatan: AmortisasiPendapatan(
                                            id_pendapatan: id_amortisasi_pendapatan,
                                            id_amortisasi_akun: id_amortisasi_akun,
                                            keterangan: text_keterangan,
                                            jumlah: jumlahBayar,
                                            jumlah_mhs: jumlahMhs,
                                            semester: semester,
                                            penyusutan: penyusutan_per_bulan,
                                            tahun_angkatan: tahun_angkatan
                                        ),
                                      id_amortisasi_pendapatan: id_amortisasi_pendapatan
                                    ));

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Future.delayed(Duration(seconds: 2),
                                                  () {
                                                _navigateToPendapatan(context);
                                              });
                                          return DialogNoButton(
                                              content: "Berhasil Diupdate!",
                                              content_detail:
                                              "Amortisasi Pendapatan baru berhasil diupdate",
                                              path_image:
                                              'assets/images/tambah_coa.png');
                                        });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Pastikan semua kolom inputan terisi."))
                                    );
                                  }

                                  /*showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Future.delayed(Duration(seconds: 1), () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return DialogNoButton(
                                            content: "Berhasil Ditambahkan!",
                                            content_detail:
                                            "Amortisasi Pendapatan berhasil diedit ditambahkan",
                                            path_image:
                                            'assets/images/tambah_coa.png');
                                      });*/
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
