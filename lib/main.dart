import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/amortisasi_aset.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/detail_amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/ui/screen/Amortisasi/tambah_akun_amortisasi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/screen/login.dart';
import 'package:sistem_akuntansi/ui/screen/CoA/list_coa.dart';


import 'ui/screen/Amortisasi/detail_amortisasi_aset.dart';
import 'ui/screen/Amortisasi/edit_amortisasi_aset.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://eohvczegrspdvlfqeody.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvaHZjemVncnNwZHZsZnFlb2R5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njk4Nzg1MjIsImV4cCI6MTk4NTQ1NDUyMn0.lu0_-WgadrCo8x2kn9bQmocjTO0Oo98aeLSeQU1BSso'
  );
  Bloc.observer = SiakBlocObserver();

  runApp(MyApp(client: Supabase.instance.client));
}

class SiakBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget {

  const MyApp({required this.client, super.key});

  final SupabaseClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Jangan Dihapus!
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ], home: ListCOA(client: Supabase.instance.client));
    // return MaterialApp(home: SideNavigationBar(client: Supabase.instance.client));
    // return MaterialApp(home: Login(client: Supabase.instance.client));
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(home: SideNavigationBar(index: 0, coaIndex: 0, bukuBesarIndex: 0, client: client));
    // return MaterialApp(home: SideNavigationBar(client: Supabase.instance.client));*/
  }
}
