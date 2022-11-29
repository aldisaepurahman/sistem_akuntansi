import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SideNavigationBar());
  }
}