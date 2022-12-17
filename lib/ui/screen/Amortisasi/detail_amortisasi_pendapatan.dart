import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_pendapatan/amortisasi_pendapatan_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_pendapatan/amortisasi_pendapatan_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan_detail.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/utils/V_LabaRugi.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailAmortisasiPendapatan extends StatefulWidget {
  final SupabaseClient client;
  final AmortisasiPendapatan pendapatan;

  const DetailAmortisasiPendapatan(
      {required this.client, required this.pendapatan, Key? key})
      : super(key: key);

  @override
  DetailAmortisasiPendapatanState createState() {
    return DetailAmortisasiPendapatanState();
  }
}

class DetailAmortisasiPendapatanState
    extends State<DetailAmortisasiPendapatan> {
  void _navigateToEditPendapatan(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 5,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
              params: {"pendapatan": widget.pendapatan},
            )));
  }

  void _navigateSelf(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SideNavigationBar(
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
            )));
  }

  void _navigateToPendapatan(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 3,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
            )));
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

  late AmortisasiPendapatanBloc _pendapatanBloc;
  var amortisasiDetail = <AmortisasiPendapatanDetail>[];

  @override
  void initState() {
    super.initState();

    _pendapatanBloc = AmortisasiPendapatanBloc(
        service: SupabaseService(supabaseClient: widget.client))
      ..add(AmortisasiPendapatanDetailFetched(
          id_amortisasi_pendapatan: widget.pendapatan.id_pendapatan));
  }

  String keterangan = "Biaya Administrasi Pendaftaran";
  String jumlah_mahasiswa = "78";
  String total_harga = "250.000";
  String semester = "Ganjil";
  int penyusutan = 3250000;
  String akun = "S1 Keperawatan";

  TextEditingController persentase = TextEditingController();
  int _case = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Detail Amortisasi Pendapatan',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: BlocProvider<AmortisasiPendapatanBloc>(
              create: (context) => _pendapatanBloc,
              child: BlocBuilder<AmortisasiPendapatanBloc, SiakState>(
                builder: (_, state) {
                  if (state is LoadingState || state is FailureState) {
                    return const SizedBox(width: 30, height: 30);
                  }
                  if (state is SuccessState) {
                    amortisasiDetail = state.datastore;

                    var idx = amortisasiDetail.indexWhere(
                            (element) => element.bulan == listbulan[DateTime.now().month] &&
                            element.tahun == DateTime.now().year
                    );

                    _case = (idx >= 0) ? 2 : 1;
                    if (_case == 2) {
                      persentase.text = amortisasiDetail[idx].nominal_penyusutan.toInt().toString();
                    }

                    return ListView(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: 25, bottom: 15, left: 25, right: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ButtonBack(
                                  onPressed: () {
                                    setState(() {
                                      _navigateToPendapatan(context);
                                    });
                                  },
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                            child: HeaderText(
                                content: "Amortisasi Pendapatan",
                                size: 32,
                                color: hitam)),
                        Container(
                            width: 30,
                            margin: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kuning,
                                        padding: const EdgeInsets.all(18)),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return DialogPenyusutan(
                                              penyusutan: _case == 1 ? (widget.pendapatan.jumlah_mhs * widget.pendapatan.penyusutan) : amortisasiDetail[idx].nominal_penyusutan.toInt(),
                                              first_desc: "Estimasi Nilai Pendapatan dalam bulan ini sebesar",
                                              sec_desc: ". Apakah Anda ingin menggunakan nilai pendapatan ini? Silahkan masukkan nominal pendapatan yang anda inginkan",
                                              persentase: persentase,
                                              onPressed: () {
                                                var id_detail = _case == 1 ? "${DateFormat(
                                                    'yyyy-MM-dd').format(
                                                    DateTime.now())}_${getRandomString(13)}" : amortisasiDetail[idx].id_detail;
                                                var bulan = listbulan[DateTime.now().month];
                                                var tahun = DateTime.now().year;
                                                var kali = 0;

                                                if (persentase.text.isNotEmpty) {
                                                  kali = int.parse(persentase.text);
                                                  if (_case == 1) {
                                                    _pendapatanBloc.add(AmortisasiDetailPendapatanInserted(
                                                        pendapatan_detail: AmortisasiPendapatanDetail(
                                                            id_detail: id_detail,
                                                            id_amortisasi_pendapatan: widget.pendapatan.id_pendapatan,
                                                            bulan: bulan!,
                                                            tahun: tahun,
                                                            nominal_penyusutan: kali
                                                        )
                                                    ));

                                                    Future.delayed(Duration(seconds: 2),
                                                            () {
                                                          _navigateSelf(context);
                                                        });
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text("Data penyusutan bulan ini sudah terisi"))
                                                    );
                                                  } else {
                                                    _pendapatanBloc.add(AmortisasiDetailPendapatanUpdated(
                                                        pendapatan_detail: AmortisasiPendapatanDetail(
                                                            id_detail: id_detail,
                                                            id_amortisasi_pendapatan: widget.pendapatan.id_pendapatan,
                                                            bulan: bulan!,
                                                            tahun: tahun,
                                                            nominal_penyusutan: kali
                                                        ),
                                                      id_amortisasi_detail: id_detail
                                                    ));

                                                    Future.delayed(Duration(seconds: 2),
                                                            () {
                                                          _navigateSelf(context);
                                                        });
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(content: Text("Data penyusutan bulan ini sudah diubah"))
                                                    );
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text("Pastikan kolom persentase terisi."))
                                                  );
                                                }
                                              },
                                              onPressed2: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                            );
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              _case == 1 ? Icons.add : Icons.edit,
                                              size: 13,
                                              color: hitam,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _case == 1 ? "Tambah Penyusutan Pendapatan Bulan Ini" : "Ubah Penyusutan Pendapatan Bulan Ini",
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
                              ],
                            )),
                        Container(
                          margin:
                          EdgeInsets.only(left: 25, right: 25, bottom: 80, top: 25),
                          padding: EdgeInsets.all(25),
                          color: background2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: HeaderText(
                                      content: "Detail Amortisasi Pendapatan",
                                      size: 24,
                                      color: kuning)),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DetailText(
                                            header: "Keterangan", content: widget.pendapatan.keterangan),
                                        DetailText(
                                            header: "Tahun Angkatan",
                                            content: "${widget.pendapatan.tahun_angkatan}"),
                                        DetailText(
                                            header: "Jumlah Pendapatan",
                                            content: "Rp ${widget.pendapatan.jumlah}"),
                                        DetailText(
                                            header: "Estimasi Pendapatan Bulan ini",
                                            content: "Rp ${widget.pendapatan.penyusutan * widget.pendapatan.jumlah_mhs}")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4 - 50,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DetailText(
                                            header: "Jumlah Mahasiswa",
                                            content: "${widget.pendapatan.jumlah_mhs} orang"),
                                        DetailText(
                                            header: "Semester", content: widget.pendapatan.semester),
                                        DetailText(
                                            header: "Penyusutan",
                                            content: "Rp ${widget.pendapatan.penyusutan}"),
                                        DetailText(
                                            header: "Pendapatan Bulan ini",
                                            content: "Rp ${idx >= 0 ? amortisasiDetail[idx].nominal_penyusutan : 0}")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 40, bottom: 20),
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kuning,
                                      padding: EdgeInsets.all(20)),
                                  onPressed: () {
                                    setState(() {
                                      _navigateToEditPendapatan(context);
                                    });
                                  },
                                  child: const Text(
                                    "Edit",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color.fromARGB(255, 50, 52, 55),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 25),
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                      padding: EdgeInsets.all(20)),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog2Button(
                                              content: "Hapus Amortisasi Pendapatan",
                                              content_detail:
                                              "Anda yakin ingin menghapus data ini?",
                                              path_image: 'assets/images/hapus_coa.png',
                                              button1: "Tetap Simpan",
                                              button2: "Ya, Hapus",
                                              onPressed1: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              onPressed2: () {
                                                setState(() {
                                                  _pendapatanBloc.add(AmortisasiPendapatanDeleted(id_amortisasi_pendapatan:  widget.pendapatan.id_pendapatan));
                                                  Future.delayed(Duration(seconds: 2),
                                                          () {
                                                        _navigateToPendapatan(context);
                                                      });
                                                });
                                              });
                                        });
                                  },
                                  child: const Text(
                                    "Hapus",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color.fromARGB(255, 245, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox(width: 30, height: 30);
                },
              ),
            )));
  }
}
