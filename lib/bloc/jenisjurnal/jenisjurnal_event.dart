import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';

class JenisJurnalFetched extends Event {
  final String tipe;

  JenisJurnalFetched({this.tipe = ""});
}

class JenisJurnalInserted extends Event {
  final JenisJurnal jenis_jurnal;

  JenisJurnalInserted({required this.jenis_jurnal});
}

class JenisJurnalUpdated extends Event {
  final JenisJurnal jenis_jurnal;
  final int id_jurnal;

  JenisJurnalUpdated({required this.jenis_jurnal, this.id_jurnal = 0});
}

class JenisJurnalDeleted extends Event {
  final int id_jurnal;

  JenisJurnalDeleted({this.id_jurnal = 0});
}