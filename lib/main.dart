import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sistem_akuntansi/ui/screen/login.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    maximumSize: Size(2560, 1440),
    minimumSize: Size(1366, 768),
    title: "Sistem Informasi Akuntansi STIKes Borromeus",
    center: true,
  );

  await Supabase.initialize(
      url: 'https://eohvczegrspdvlfqeody.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvaHZjemVncnNwZHZsZnFlb2R5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njk4Nzg1MjIsImV4cCI6MTk4NTQ1NDUyMn0.lu0_-WgadrCo8x2kn9bQmocjTO0Oo98aeLSeQU1BSso');
  Bloc.observer = SiakBlocObserver();

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final SharedPreferences pref = await SharedPreferences.getInstance();
  final String user = pref.getString("user") ?? "";
  bool isLogin = user.isNotEmpty ? true : false;

  runApp(MyApp(client: Supabase.instance.client, status: isLogin));
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
  const MyApp({required this.client, required this.status, super.key});

  final SupabaseClient client;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //Jangan Dihapus!
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        home: this.status
            ? SideNavigationBar(
                index: 0,
                coaIndex: 0,
                jurnalUmumIndex: 0,
                bukuBesarIndex: 0,
                neracaLajurIndex: 0,
                labaRugiIndex: 0,
                amortisasiIndex: 0,
                jurnalPenyesuaianIndex: 0,
                client: client,
              )
            : Login(client: Supabase.instance.client));
    // return MaterialApp(home: SideNavigationBar(client: Supabase.instance.client));
    // return MaterialApp(home: Login(client: Supabase.instance.client));
    /*@override
  Widget build(BuildContext context) {
    return MaterialApp(home: SideNavigationBar(index: 0, coaIndex: 0, bukuBesarIndex: 0, client: client));
    // return MaterialApp(home: SideNavigationBar(client: Supabase.instance.client));*/
  }
}
