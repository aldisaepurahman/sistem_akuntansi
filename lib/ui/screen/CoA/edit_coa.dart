import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_bloc.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/saldo.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditCOA extends StatefulWidget {
  const EditCOA({required this.client, required this.akun, required this.akun_saldo, Key? key}) : super(key: key);

  final SupabaseClient client;
  final Akun akun;
  final Saldo akun_saldo;

  @override
  EditCOAState createState() {
    return EditCOAState();
  }
}

class EditCOAState extends State<EditCOA> {

  void _navigateToDetailCoa(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) =>
        SideNavigationBar(
          index: 1,
          coaIndex: 2,
          jurnalUmumIndex: 0,
          bukuBesarIndex: 0,
          labaRugiIndex: 0,
          neracaLajurIndex: 0,
          amortisasiIndex: 0,
          jurnalPenyesuaianIndex: 0,
          client: widget.client,
          params: {"akun": widget.akun},
        )
      )
    );
  }

  void _navigateToListCoa(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                SideNavigationBar(
                    index: 1,
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
  
  late TextEditingController namaAkunController;
  late TextEditingController kodeController;
  late TextEditingController keteranganController;
  late TextEditingController indentasiController;
  late TextEditingController saldoController;

  Map<int, String> listbulan =
  {
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
    namaAkunController.dispose();
    kodeController.dispose();
    keteranganController.dispose();
    indentasiController.dispose();
    saldoController.dispose();
  }

  @override
  void initState() {
    super.initState();
    namaAkunController = TextEditingController(text: widget.akun.nama_akun);
    kodeController = TextEditingController(text: widget.akun.kode_akun);
    keteranganController = TextEditingController(text: widget.akun.keterangan_akun);
    indentasiController = TextEditingController(text: widget.akun.indentasi.toString());
    saldoController = TextEditingController(text: (widget.akun_saldo.id_saldo > 0) ? widget.akun_saldo.saldo.toString() : "0");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Edit Chart of Account',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
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
                                          _navigateToDetailCoa(context);
                                        });
                                  });
                            });
                          },
                        )
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 25),
                  child: Text(
                    "Edit Chart of Account",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 50, 52, 55)),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 25, bottom: 60, right: 25, left: 25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Informasi CoA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 204, 0)),
                      )),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Nama Akun",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          controller: namaAkunController,
                          decoration: InputDecoration(
                              hintText: 'Masukkan nama akun...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    readOnly: true,
                                    controller: kodeController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.black12,
                                        hintText: 'Masukkan kode...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                            BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Keterangan',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    controller: keteranganController,
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan keterangan...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Indentasi',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    controller: indentasiController,
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan indentasi...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Saldo Awal (Opsional)",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          controller: saldoController,
                          decoration: InputDecoration(
                              labelText: 'Rp',
                              hintText: 'Masukkan saldo awal...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 204, 0),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            var nama_akun = namaAkunController.text;
                            var kode_akun = kodeController.text;
                            var keterangan = keteranganController.text;
                            var indentasi = indentasiController.text;
                            var saldo = saldoController.text;
                            var bulan = (widget.akun_saldo.bulan.isNotEmpty) ? widget.akun_saldo.bulan : listbulan[DateTime.now().month];
                            var tahun = (widget.akun_saldo.tahun > 0) ? widget.akun_saldo.tahun : DateTime.now().year;

                            if (nama_akun.isNotEmpty && kode_akun.isNotEmpty && keterangan.isNotEmpty && indentasi.isNotEmpty) {
                              AkunBloc(service: SupabaseService(supabaseClient: widget.client)).add(
                                  AkunUpdated(
                                      akun: Akun(
                                          kode_akun: kode_akun,
                                          nama_akun: nama_akun,
                                          keterangan_akun: keterangan,
                                          indentasi: int.parse(indentasi)
                                      ),
                                      saldo: Saldo(
                                          kode_akun: kode_akun,
                                          saldo: int.parse(saldo),
                                          bulan: bulan!!,
                                          tahun: tahun
                                      ),
                                    kode_akun: widget.akun.kode_akun,
                                    id_saldo: widget.akun_saldo.id_saldo
                                  )
                              );

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Future.delayed(Duration(seconds: 2), () {
                                      _navigateToListCoa(context);
                                    });
                                    return DialogNoButton(
                                        content: "Berhasil Diedit!",
                                        content_detail:
                                        "Chart of Account berhasil diedit",
                                        path_image:
                                        'assets/images/tambah_coa.png');
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Pastikan seluruh kolom terisi, kecuali kolom saldo awal"))
                              );
                            }
                          },
                          child: Text(
                            "Simpan",
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
                                    _navigateToDetailCoa(context);
                                  }
                                );
                              }
                            );
                          },
                          child: Text(
                            "Batalkan",
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
            )
        )
    );
  }
}
