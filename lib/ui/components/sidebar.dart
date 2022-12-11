import 'package:sistem_akuntansi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedIndex = 0;
    return SidebarX(
      controller: SidebarXController(selectedIndex: 0, extended: true),
      extendedTheme: SidebarXTheme(
        width: 300,
      ),
      theme: SidebarXTheme(
        padding: EdgeInsets.all(32),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 40,
          child: Image.asset('assets/images/Logo_STIKes.png'),
        );
      },
      items: [
        SidebarXItem(
          iconWidget: SvgPicture.asset(
            'assets/icons/Eye.svg',
            color: selectedIndex == 0 ? yellowPrime : textColor,
          ),
          label: "Dashboard",
        ),
      ],
    );
  }
}
