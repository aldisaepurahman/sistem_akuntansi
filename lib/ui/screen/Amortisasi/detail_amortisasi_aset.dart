import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_bloc.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset_detail.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailAmortisasiAset extends StatefulWidget {
  final SupabaseClient client;
  final AmortisasiAset aset;

  const DetailAmortisasiAset({required this.client, required this.aset, Key? key})
      : super(key: key);

  @override
  DetailAmortisasiAsetState createState() {
    return DetailAmortisasiAsetState();
  }
}

class DetailAmortisasiAsetState extends State<DetailAmortisasiAset> {
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
              amortisasiIndex: 1,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
              params: {"aset": widget.aset},
            )
    )
    );
  }

  void _navigateToEditAset(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SideNavigationBar(
              index: 6,
              coaIndex: 0,
              jurnalUmumIndex: 0,
              bukuBesarIndex: 0,
              neracaLajurIndex: 0,
              labaRugiIndex: 0,
              amortisasiIndex: 2,
              jurnalPenyesuaianIndex: 0,
              client: widget.client,
              params: {"aset": widget.aset},
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

  late AmortisasiAsetBloc _asetBloc;
  var amortisasiDetail = AmortisasiAsetDetail();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _asetBloc = AmortisasiAsetBloc(service: SupabaseService(supabaseClient: widget.client))..add(AmortisasiAsetDetailFetched(id_amortisasi_aset: widget.aset.id_amortisasi_aset));
  }

  String keterangan = "NEBULIZER ULTRASONIC - HIBAH PHP PTS 2013";
  String saat_perolehan = "Desember'13";
  String masa_guna = "4";
  String akun = "Peralatan Laboratorium";
  String penyusutan = "229.167";
  String akumulasi_penyusutan_tahun_lalu = "11.000.000";
  String nilai_perolehan = "11.000.000";

  TextEditingController persentase = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Detail Amortisasi Aset',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: BlocProvider<AmortisasiAsetBloc>(
              create: (context) => _asetBloc,
              child: ListView(
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
                                _navigateToAset(context);
                              });
                            },
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                      child: HeaderText(
                          content: "Amortisasi Aset", size: 32, color: hitam)),
                  Container(
                      width: 30,
                      margin: EdgeInsets.only(left: 25, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BlocBuilder<AmortisasiAsetBloc, SiakState>(
                              builder: (_, state) {
                                if (state is LoadingState || state is FailureState) {
                                  return const SizedBox(width: 30);
                                }
                                if (state is SuccessState) {
                                  amortisasiDetail = state.datastore;

                                  return Visibility(
                                    visible: (amortisasiDetail.tahun == 0) ? true : false,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kuning,
                                              padding: const EdgeInsets.all(18)),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return DialogPenyusutan(
                                                      penyusutan: widget.aset.penyusutan,
                                                      persentase: persentase,
                                                      onPressed: () {
                                                        var bulan = listbulan[DateTime.now().month-1];
                                                        var tahun = DateTime.now().year;
                                                        var kali = 0.0;

                                                        if (persentase.text.isNotEmpty) {
                                                          kali = double.parse(persentase.text) / 100;
                                                          _asetBloc.add(AmortisasiDetailAsetInserted(
                                                              aset_detail: AmortisasiAsetDetail(
                                                                  id_amortisasi_aset: widget.aset.id_amortisasi_aset,
                                                                  bulan: bulan!,
                                                                  tahun: tahun,
                                                                  kali: kali
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
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text("Pastikan kolom persentase terisi."))
                                                          );
                                                        }
                                                      },
                                                    onPressed2: () {
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      }); //belum diset
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
                                                    Icons.add,
                                                    size: 13,
                                                    color: hitam,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Tambah Penyusutan Bulan Ini",
                                                    style: TextStyle(
                                                      fontFamily: "Inter",
                                                      color: hitam,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )));
                                }
                                return const SizedBox(width: 30);
                              },
                          )
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
                                content: "Detail Amortisasi Aset",
                                size: 24,
                                color: kuning)),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              // width: MediaQuery.of(context).size.width * 0.4 - 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailText(
                                      header: "Keterangan", content: widget.aset.keterangan),
                                  DetailText(
                                      header: "Nilai Perolehan",
                                      content: "Rp ${widget.aset.nilai_awal}"),
                                  DetailText(
                                      header: "Akumulasi Penyusutan Tahun Lalu",
                                      content:
                                      "Rp ${widget.aset.akumulasi}")
                                ],
                              ),
                            ),
                            Expanded(
                              // width: MediaQuery.of(context).size.width * 0.4 - 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailText(
                                      header: "Masa Guna", content: widget.aset.masa_guna.toString()),
                                  DetailText(
                                      header: "Saat Perolehan",
                                      content: "${widget.aset.bulan_perolehan} ${widget.aset.tahun_perolehan}"),
                                  DetailText(
                                      header: "Penyusutan",
                                      content: "Rp ${widget.aset.penyusutan}")
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
                                _navigateToEditAset(context);
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
                                        content: "Hapus Amortisasi Aset",
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
                                            _asetBloc.add(AmortisasiAsetDeleted(id_amortisasi_aset: widget.aset.id_amortisasi_aset));
                                            Future.delayed(Duration(seconds: 2),
                                                    () {
                                                      _navigateToAset(context);
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
              ),
            )));
  }
}
