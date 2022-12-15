import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan_detail.dart';

class AmortisasiPendapatanFetched extends Event {
  final String semester;
  final String id_amortisasi_akun;

  AmortisasiPendapatanFetched({this.semester = "", this.id_amortisasi_akun = ""});
}

class AmortisasiPendapatanDetailFetched extends Event {
  final String id_amortisasi_pendapatan;

  AmortisasiPendapatanDetailFetched({this.id_amortisasi_pendapatan = ""});
}

class AmortisasiPendapatanInserted extends Event {
  final AmortisasiPendapatan pendapatan;

  AmortisasiPendapatanInserted({required this.pendapatan});
}

class AmortisasiDetailPendapatanInserted extends Event {
  final AmortisasiPendapatanDetail pendapatan_detail;

  AmortisasiDetailPendapatanInserted({required this.pendapatan_detail});
}

class AmortisasiPendapatanUpdated extends Event {
  final AmortisasiPendapatan pendapatan;
  final String id_amortisasi_pendapatan;

  AmortisasiPendapatanUpdated({required this.pendapatan, required this.id_amortisasi_pendapatan});
}

class AmortisasiPendapatanDeleted extends Event {
  final String id_amortisasi_pendapatan;

  AmortisasiPendapatanDeleted({required this.id_amortisasi_pendapatan});
}