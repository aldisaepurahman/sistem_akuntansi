import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/saldo.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/edit_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/list_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/insert_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/detail_coa.dart';
import 'package:sistem_akuntansi/ui/screen/BukuBesar/list_bukubesar.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/detail_transaksi.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/jurnal_umum.dart';
import 'package:sistem_akuntansi/ui/screen/JurnalUmum/transaksi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SideNavigationBar extends StatefulWidget{
  final int index;
  final int coaIndex;
  final int bukuBesarIndex;
  final SupabaseClient client;
  final Map<String, dynamic>? params;

  SideNavigationBar(
      {Key? key,
        required this.index,
        required this.coaIndex,
        required this.bukuBesarIndex,
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
  int selectedBukuBesarIndex = 0;
  List<Widget> _mainContents = [];

  Widget getCoaPage(){
    if (selectedCoaIndex == 1) {
      return InsertCOA(client: widget.client);
    }
    else if (selectedCoaIndex == 2) {
      return DetailCOA(client: widget.client, akun: widget.params?['akun'] as Akun);
    }
    else if (selectedCoaIndex == 3) {
      return EditCOA(client: widget.client, akun: widget.params?['akun'] as Akun, akun_saldo: widget.params?['akun_saldo'] as Saldo);
    }
    return ListCOA(client: widget.client);
  }

  Widget getBukuBesarPage(){
    return ListBukuBesar(client: widget.client);
  }

  Widget getJurnalUmum() {
    if (selectedCoaIndex == 1) {
      return TransaksiList();
    }
    else if (selectedCoaIndex == 2) {
      return DetailTransaksi();
    }
    return JurnalUmumList(client: widget.client);
  }

  @override
  void initState() {
    selectedCoaIndex = widget.coaIndex;
    selectedIndex = widget.index;

    _mainContents = [
      Text('Ini page dashboard'),

      getCoaPage(),

      getJurnalUmum(),

      getBukuBesarPage(),
    ];
  }


  String whiteColor = "#ffffff".replaceAll('#', '0xff');
  String greyBackgroundColor = "#f8f9fd".replaceAll('#', '0xff');
  String greyFontColor = "#b7b7b7".replaceAll('#', '0xff');
  String yellowTextColor = "#ffcc00".replaceAll('#', '0xff');

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
            Container(
              color: Color(int.parse(whiteColor)),
              width: MediaQuery.of(context).size.width / 5,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: _changeIndex,
                  labelType: NavigationRailLabelType.all,
                  destinations: _buildDestinations(),
                  selectedIconTheme: IconThemeData(color: Color(int.parse(yellowTextColor))),
                  unselectedIconTheme: IconThemeData(color: Color(int.parse(greyFontColor))),
                  selectedLabelTextStyle: TextStyle(color: Color(int.parse(yellowTextColor))),
                  unselectedLabelTextStyle: TextStyle(color: Color(int.parse(greyFontColor))),
                ),
              )
            ),
            Expanded(
              child: Container(
                color: Color(int.parse(greyBackgroundColor)),
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
        icon: SizedBox.shrink(),
        label: Container(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 7),
                child: Icon(selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
                  color: selectedIndex == 0 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
                ),
              ),
              Text('Dashboard'),
            ],
          ),
        )
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: Container(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 7),
                child: Icon(selectedIndex == 1 ? Icons.compare_arrows_sharp : Icons.compare_arrows_sharp,
                  color: selectedIndex == 1 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
                ),
              ),
              Text('CoA'),
            ],
          ),
        )
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: Container(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 7),
                child: Icon(selectedIndex == 2 ? Icons.account_balance_wallet_rounded : Icons.account_balance_wallet_outlined,
                  color: selectedIndex == 2 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
                ),
              ),
              Text('Jurnal Umum'),
            ],
          ),
        )
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        label: Container(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 7),
                child: Icon(selectedIndex == 3 ? Icons.sticky_note_2_rounded : Icons.sticky_note_2_outlined,
                  color: selectedIndex == 3 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
                ),
              ),
              Text('Buku Besar'),
            ],
          ),
        )
      ),
    ];
  }
}