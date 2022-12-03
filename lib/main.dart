import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/SideNavigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SideNavigationBar(index: 0, coaIndex: 0,));
  }
}