import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/list_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/insert_coa.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/detail_coa.dart';
import 'package:sistem_akuntansi/ui/screen/BukuBesar/list_bukubesar.dart';
import 'package:sistem_akuntansi/ui/screen/BukuBesar/list_bukubesarperbulan.dart';

class SideNavigationBar extends StatefulWidget{
  final int index;
  final int coaIndex;
  final int bukuBesarIndex;

  SideNavigationBar(
      {Key? key,
        required this.index,
        required this.coaIndex,
        required this.bukuBesarIndex,
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
  bool isExtended = false;

  Widget getCoaPage(){
    if (selectedCoaIndex == 1) {
      return InsertCOA();
    }
    else if (selectedCoaIndex == 2) {
      return DetailCOA();
    }
    return ListCOA();
  }

  Widget getBukuBesarPage(){
    if (selectedBukuBesarIndex == 1) {
      return ListBukuBesarPerBulan();
    }
    return ListBukuBesar();
  }

  @override
  void initState() {
    selectedIndex = widget.index;
    selectedCoaIndex = widget.coaIndex;
    selectedBukuBesarIndex = widget.bukuBesarIndex;

    _mainContents = [
      Text('Ini page dashboard'),

      getCoaPage(),

      Text('Ini page Jurnal Umum'),

      getBukuBesarPage(),
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
                  color: Color(int.parse(whiteColor)),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: NavigationRail(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: _changeIndex,
                      extended: isExtended,
                      labelType: (isExtended==false) ? NavigationRailLabelType.all : NavigationRailLabelType.none,
                      destinations: _buildDestinations(),
                      selectedIconTheme: IconThemeData(color: Color(int.parse(yellowTextColor))),
                      unselectedIconTheme: IconThemeData(color: Color(int.parse(greyFontColor))),
                      selectedLabelTextStyle: TextStyle(color: Color(int.parse(yellowTextColor))),
                      unselectedLabelTextStyle: TextStyle(color: Color(int.parse(greyFontColor))),
                      minWidth: 50,
                      leading: Row(
                        children: [
                          Image.asset(
                            "images/logo_stikes.jpg",
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
        icon: (isExtended == true ? SizedBox.shrink() : Icon(selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
          color: selectedIndex == 0 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
              color: selectedIndex == 0 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
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
          color: selectedIndex == 1 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 1 ? Icons.compare_arrows_sharp : Icons.compare_arrows_sharp,
              color: selectedIndex == 1 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
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
          color: selectedIndex == 2 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 2 ? Icons.account_balance_wallet_rounded : Icons.account_balance_wallet_outlined,
              color: selectedIndex == 2 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
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
          color: selectedIndex == 3 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
        )),
        label: (isExtended == true ? Row(
          children: [
            Icon(selectedIndex == 3 ? Icons.sticky_note_2_rounded : Icons.sticky_note_2_outlined,
              color: selectedIndex == 3 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
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
    ];
  }
}