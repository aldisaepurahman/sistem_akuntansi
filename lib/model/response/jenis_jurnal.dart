import 'package:equatable/equatable.dart';

class JenisJurnal extends Equatable {
  final int id_jenis_jurnal;
  final String nama_jurnal;

  const JenisJurnal({this.id_jenis_jurnal = 0, required this.nama_jurnal});

  factory JenisJurnal.fromJson(Map<String, dynamic> json) {
    return JenisJurnal(
        id_jenis_jurnal: json['id_jenis_jurnal'],
        nama_jurnal: json['nama_jurnal']);
  }

  Map<String, dynamic> toJson() {
    return {'nama_jurnal': this.nama_jurnal};
  }

  @override
  List<Object> get props => [id_jenis_jurnal, nama_jurnal];
}
