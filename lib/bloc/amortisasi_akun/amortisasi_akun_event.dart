import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';

class AmortisasiAkunFetched extends Event {}

class AmortisasiAkunInserted extends Event {
  final AmortisasiAkun akun;

  AmortisasiAkunInserted({required this.akun});
}

class AmortisasiAkunDeleted extends Event {
  final String id_amortisasi_akun;

  AmortisasiAkunDeleted({required this.id_amortisasi_akun});
}