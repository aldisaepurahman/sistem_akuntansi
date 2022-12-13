import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset_detail.dart';

class AmortisasiAsetFetched extends Event {
  final int tahun;
  final String id_amortisasi_akun;

  AmortisasiAsetFetched({this.tahun = 0, this.id_amortisasi_akun = ""});
}

class AmortisasiAsetDetailFetched extends Event {
  final String id_amortisasi_aset;

  AmortisasiAsetDetailFetched({this.id_amortisasi_aset = ""});
}

class AmortisasiAsetInserted extends Event {
  final AmortisasiAset aset;

  AmortisasiAsetInserted({required this.aset});
}

class AmortisasiDetailAsetInserted extends Event {
  final AmortisasiAsetDetail aset_detail;

  AmortisasiDetailAsetInserted({required this.aset_detail});
}

class AmortisasiAsetUpdated extends Event {
  final AmortisasiAset aset;
  final String id_amortisasi_aset;

  AmortisasiAsetUpdated({required this.aset, required this.id_amortisasi_aset});
}

class AmortisasiAsetDeleted extends Event {
  final String id_amortisasi_aset;

  AmortisasiAsetDeleted({required this.id_amortisasi_aset});
}