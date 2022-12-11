import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/screen/login.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://eohvczegrspdvlfqeody.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvaHZjemVncnNwZHZsZnFlb2R5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njk4Nzg1MjIsImV4cCI6MTk4NTQ1NDUyMn0.lu0_-WgadrCo8x2kn9bQmocjTO0Oo98aeLSeQU1BSso'
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: SideNavigationBar(index: 0, coaIndex: 0, jurnalUmumIndex: 0, bukuBesarIndex: 0, client: Supabase.instance.client));
    return MaterialApp(home: Login(client: Supabase.instance.client));
  }
}