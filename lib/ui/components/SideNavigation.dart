import 'package:flutter/material.dart';

class SideNavigationBar extends StatefulWidget{
  @override
  State<SideNavigationBar> createState() {
    return _SideNavigationBar();
  }
}

class _SideNavigationBar extends State<SideNavigationBar> {
  int _selectedIndex = 0;

  String whiteColor = "#ffffff".replaceAll('#', '0xff');
  String greyBackgroundColor = "#f8f9fd".replaceAll('#', '0xff');
  String greyFontColor = "#b7b7b7".replaceAll('#', '0xff');
  String yellowTextColor = "#ffcc00".replaceAll('#', '0xff');

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _mainContents = [
    Text('Ini page dashboard'),
    Text('Ini page CoA'),
    Text('Ini page Saldo Awal'),
    Text('Ini page Jurnal Umum'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _changeIndex,
              labelType: NavigationRailLabelType.all,
              destinations: _buildDestinations(),

              selectedIconTheme: IconThemeData(color: Color(int.parse(yellowTextColor))),
              unselectedIconTheme: IconThemeData(color: Color(int.parse(greyFontColor))),
              selectedLabelTextStyle: TextStyle(color: Color(int.parse(yellowTextColor))),
              unselectedLabelTextStyle: TextStyle(color: Color(int.parse(greyFontColor))),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(int.parse(greyBackgroundColor)),
              width: double.infinity,
              height: double.infinity,
              child: _mainContents[_selectedIndex],
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
        // icon: Icon(Icons.grid_view_outlined),
        // selectedIcon: Icon(Icons.grid_view_sharp),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Icon(_selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view_outlined,
                color: _selectedIndex == 0 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
              ),
            ),
            Text('Dashboard'),
          ],
        ),
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        // icon: Icon(Icons.grid_view_outlined),
        // selectedIcon: Icon(Icons.grid_view_sharp),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Icon(_selectedIndex == 1 ? Icons.compare_arrows_sharp : Icons.compare_arrows_sharp,
                color: _selectedIndex == 1 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
              ),
            ),
            Text('CoA'),
          ],
        ),
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        // icon: Icon(Icons.grid_view_outlined),
        // selectedIcon: Icon(Icons.grid_view_sharp),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Icon(_selectedIndex == 2 ? Icons.account_balance_wallet_rounded : Icons.account_balance_wallet_outlined,
                color: _selectedIndex == 2 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
              ),
            ),
            Text('Saldo Awal'),
          ],
        ),
      ),
      NavigationRailDestination(
        icon: SizedBox.shrink(),
        // icon: Icon(Icons.grid_view_outlined),
        // selectedIcon: Icon(Icons.grid_view_sharp),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Icon(_selectedIndex == 3 ? Icons.sticky_note_2_rounded : Icons.sticky_note_2_outlined,
                color: _selectedIndex == 3 ? Color(int.parse(yellowTextColor)) : Color(int.parse(greyFontColor)),
              ),
            ),
            Text('Jurnal Umum'),
          ],
        ),
      ),
    ];
  }
}