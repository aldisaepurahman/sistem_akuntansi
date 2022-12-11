import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/amortisasi_aset.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/detail_amortisasi_aset.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/detail_amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/edit_amortisasi_aset.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/edit_amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/tambah_akun_amortisasi.dart';
import 'package:sistem_akuntansi/ui/screen/login.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/saldo.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/edit_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/list_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/insert_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/detail_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/edit_coa.dart';
import 'package:sistem_akuntansi/ui/screen/BukuBesar/list_bukubesar.dart';
import 'package:sistem_akuntansi/ui/screen/BukuBesar/bukubesar_perakun.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/detail_transaksi.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/jurnal_umum.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/transaksi.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/jenis_jurnal.dart';
import 'package:sistem_akuntansi/ui/screen/NeracaLajur/neraca_lajur.dart';
import 'package:sistem_akuntansi/ui/screen/NeracaLajur/laporan_neracalajur.dart';
import 'package:sistem_akuntansi/ui/screen/LabaRugi/laba_rugi.dart';
import 'package:sistem_akuntansi/ui/screen/LabaRugi/laporan_labarugi.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalPenyesuaian/jurnal_penyesuaian.dart';
import 'package:sistem_akuntansi/ui/screen/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SideNavigationBar extends StatefulWidget {
  final int index;
  final int coaIndex;
  final int jurnalUmumIndex;
  final int bukuBesarIndex;
  final int neracaLajurIndex;
  final int labaRugiIndex;
  final int amortisasiIndex;
  final int jurnalPenyesuaianIndex;

  final SupabaseClient client;
  final Map<String, dynamic>? params;

  SideNavigationBar(
      {Key? key,
        required this.index,
        required this.coaIndex,
        required this.jurnalUmumIndex,
        required this.bukuBesarIndex,
        required this.neracaLajurIndex,
        required this.labaRugiIndex,
        required this.amortisasiIndex,
        required this.jurnalPenyesuaianIndex,
        required this.client,
        this.params
      })
      : super(key: key);

  @override
  State<SideNavigationBar> createState() {
    return _SideNavigationBarState();
  }
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  int selectedIndex = 0;
  int selectedCoaIndex = 0;
  int selectedJurnalUmumIndex = 0;
  int selectedBukuBesarIndex = 0;
  int selectedNeracaLajurIndex = 0;
  int selectedLabaRugiIndex = 0;
  int selectedAmortisasiIndex = 0;
  int selectedJurnalPenyesuaianIndex = 0;

  List<Widget> _mainContents = [];
  bool isExtended = false;

  Widget dashboardPage(){
    return Dashboard();
  }

  Widget getCoaPage(){
    if (selectedCoaIndex == 1) {
      return InsertCOA(client: widget.client); // insert CoA
    }
    else if (selectedCoaIndex == 2) {
      return DetailCOA(client: widget.client, akun: widget.params?["akun"] as Akun); // detail CoA
    }
    else if (selectedCoaIndex == 3) {
      return EditCOA(client: widget.client, akun: widget.params?["akun"] as Akun, akun_saldo: widget.params?["akun_saldo"] as Saldo,); // edit CoA
    }
    return ListCOA(client: widget.client); // list CoA
  }

  Widget getJurnalUmum() {
    if (selectedJurnalUmumIndex == 1) {
      return JenisJurnal(client: widget.client); // tabel jenis jurnal
    } else if (selectedJurnalUmumIndex == 2) {
      return TransaksiList(client: widget.client); // tabel daftar transaksi
    } else if (selectedJurnalUmumIndex == 3) {
      return DetailTransaksi(client: widget.client); // detail transaksi
    }
    return JurnalUmumList(client: widget.client); // tabel bulan tahun jurnal
  }

  Widget getBukuBesarPage() {
    if (selectedBukuBesarIndex == 1) {
      return BukuBesarPerAkun(
          client: widget.client); // tabel buku besar per akun
    }
    return ListBukuBesar(client: widget.client); // tabel bulan tahun buku besar
  }

  Widget getNeracaLajurPage(){
    if (selectedNeracaLajurIndex == 1) {
      return LaporanNeracaLajur(client: widget.client);
    }
    return NeracaLajurList(client: widget.client);
  }

  Widget getLabaRugiPage(){
    if (selectedLabaRugiIndex == 1) {
      return LaporanLabaRugi(client: widget.client);
    }
    return LabaRugiList(client: widget.client);
  }

  Widget getAmortisasiPage(){
    if (selectedAmortisasiIndex == 1) {
      return DetailAmortisasiAset(client: widget.client);
    } else if (selectedAmortisasiIndex == 2) {
      return EditAmortisasiAset(client: widget.client);
    } else if (selectedAmortisasiIndex == 3) {
      return AmortisasiPendapatanList(client: widget.client);
    } else if (selectedAmortisasiIndex == 4) {
      return DetailAmortisasiPendapatan(client: widget.client);
    } else if (selectedAmortisasiIndex == 5) {
      return EditAmortisasiPendapatan(client: widget.client);
    } else if (selectedAmortisasiIndex == 6) {
      return TambahAkunAmortisasiList(client: widget.client);
    }
    return AmortisasiAsetList(client: widget.client);
  }

  Widget getJurnalPenyesuaianPage() {
    if (selectedJurnalPenyesuaianIndex ==  1) {
      // return
    }
    return JurnalPenyesuaianList(client: widget.client);
  }

  @override
  void initState() {
    selectedIndex = widget.index;
    selectedCoaIndex = widget.coaIndex;
    selectedJurnalUmumIndex = widget.jurnalUmumIndex;
    selectedBukuBesarIndex = widget.bukuBesarIndex;
    selectedNeracaLajurIndex = widget.neracaLajurIndex;
    selectedLabaRugiIndex = widget.labaRugiIndex;
    selectedAmortisasiIndex = widget.amortisasiIndex;
    selectedJurnalPenyesuaianIndex = widget.jurnalPenyesuaianIndex;

    _mainContents = [
      dashboardPage(),
      getCoaPage(),
      getJurnalUmum(),
      getBukuBesarPage(),
      getNeracaLajurPage(),
      getLabaRugiPage(),
      getAmortisasiPage(),
      getJurnalPenyesuaianPage(),
    ];
  }

  void _changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            MouseRegion(
              onHover: (s) {
                setState(() {
                  isExtended = true;
                });
              },
              onExit: (s) {
                setState(() {
                  isExtended = false;
                });
              },
              child: Container(
                  color: whiteColor,
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: NavigationRail(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: _changeIndex,
                      extended: isExtended,
                      labelType: (isExtended==false) ? NavigationRailLabelType.all : NavigationRailLabelType.none,
                      destinations: _buildDestinations(),
                      selectedIconTheme: IconThemeData(color: yellowTextColor),
                      unselectedIconTheme: IconThemeData(color: greyFontColor),
                      selectedLabelTextStyle: TextStyle(color: yellowTextColor),
                      unselectedLabelTextStyle: TextStyle(color: greyFontColor),
                      minWidth: 50,
                      leading: Row(
                        children: [
                          Image.asset(
                            "assets/images/logo_stikes.png",
                            height: 50,
                          ),
                          isExtended == true ? SizedBox(
                            width: 10,
                          )
                          :
                          SizedBox.shrink()
                          ,
                          isExtended == true ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SISTEM AKUNTANSI',
                                style: TextStyle(
                                  color: kuning,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                ),
                              ),
                                Text(
                                  'STIKes Santo Borromeus',
                                  style: TextStyle(
                                    color: kuning,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          )
                          :
                          SizedBox.shrink(),
                        ],
                      ),
                    ),
                )
              ),
            ),
            Expanded(
              child: Container(
                color: greyColor10,
                width: double.infinity,
                height: double.infinity,
                child: _mainContents[selectedIndex],
              ),
            ),
          ],
        )
    );
  }

  List<NavigationRailDestination> _buildDestinations() {
    return [
      NavigationRailDestination(
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
          color: selectedIndex == 0 ? yellowTextColor : greyFontColor,
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
              color: selectedIndex == 0 ? yellowTextColor : greyFontColor,
            ),
            SizedBox(width: 10),
            Text(
              'Dashboard',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ],
        )
        :
        SizedBox.shrink()
        )
      ),
      NavigationRailDestination(
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 1 ? Icons.compare_arrows_sharp : Icons.compare_arrows_sharp,
          color: selectedIndex == 1 ? yellowTextColor : greyFontColor,
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 1 ? Icons.compare_arrows_sharp : Icons.compare_arrows_sharp,
              color: selectedIndex == 1 ? yellowTextColor : greyFontColor,
            ),
            SizedBox(width: 10),
            Text(
              'CoA',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ],
        )
        :
        SizedBox.shrink()
        ),
      ),
      NavigationRailDestination(
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 2 ? Icons.account_balance_wallet_rounded : Icons.account_balance_wallet_outlined,
          color: selectedIndex == 2 ? yellowTextColor : greyFontColor,
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 2 ? Icons.account_balance_wallet_rounded : Icons.account_balance_wallet_outlined,
              color: selectedIndex == 2 ? yellowTextColor : greyFontColor,
            ),
            SizedBox(width: 10),
            Text(
              'Jurnal Umum',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ],
        )
        :
        SizedBox.shrink()
        )
      ),
      NavigationRailDestination(
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 3 ? Icons.sticky_note_2_rounded : Icons.sticky_note_2_outlined,
          color: selectedIndex == 3 ? yellowTextColor : greyFontColor,
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 3 ? Icons.sticky_note_2_rounded : Icons.sticky_note_2_outlined,
              color: selectedIndex == 3 ? yellowTextColor : greyFontColor,
            ),
            SizedBox(width: 10),
            Text(
              'Buku Besar',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ],
        )
        :
        SizedBox.shrink()
        )
      ),
      NavigationRailDestination(
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 4 ? Icons.table_chart : Icons.table_chart_outlined,
          color: selectedIndex == 4 ? yellowTextColor : greyFontColor,
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 4 ? Icons.table_chart : Icons.table_chart_outlined,
              color: selectedIndex == 4 ? yellowTextColor : greyFontColor,
            ),
            SizedBox(width: 10),
            Text(
              'Neraca Lajur',
              style: TextStyle(
                fontFamily: 'Inter',
              ),
            ),
          ],
        )
        :
        SizedBox.shrink()
        )
      ),
      NavigationRailDestination(
          icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 5 ? Icons.attach_money : Icons.attach_money,
            color: selectedIndex == 5 ? yellowTextColor : greyFontColor,
          )),
          label: (isExtended == true ? Row(
            children: [
              Icon(selectedIndex == 5 ? Icons.attach_money : Icons.attach_money,
                color: selectedIndex == 5 ? yellowTextColor : greyFontColor,
              ),
              SizedBox(width: 10),
              Text(
                'Laba Rugi',
                style: TextStyle(
                  fontFamily: 'Inter',
                ),
              ),
            ],
          )
          :
          SizedBox.shrink()
          )
      ),
      NavigationRailDestination(
          icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 6 ? Icons.trending_down_rounded : Icons.trending_down_rounded,
            color: selectedIndex == 6 ? yellowTextColor : greyFontColor,
          )),
          label: (isExtended == true ? Row(
            children: [
              Icon(selectedIndex == 6 ? Icons.trending_down_rounded : Icons.trending_down_rounded,
                color: selectedIndex == 6 ? yellowTextColor : greyFontColor,
              ),
              SizedBox(width: 10),
              Text(
                'Amortisasi',
                style: TextStyle(
                  fontFamily: 'Inter',
                ),
              ),
            ],
          )
          :
          SizedBox.shrink()
          )
      ),
      NavigationRailDestination(
          icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 7 ? Icons.mark_chat_read : Icons.mark_chat_read_outlined,
            color: selectedIndex == 7 ? yellowTextColor : greyFontColor,
          )),
          label: (isExtended == true ? Row(
            children: [
              Icon(selectedIndex == 7 ? Icons.mark_chat_read : Icons.mark_chat_read_outlined,
                color: selectedIndex == 7 ? yellowTextColor : greyFontColor,
              ),
              SizedBox(width: 10),
              Text(
                'Jurnal Penyesuaian',
                style: TextStyle(
                  fontFamily: 'Inter',
                ),
              ),
            ],
          )
          :
          SizedBox.shrink()
        )
      ),
    ];
  }
}
