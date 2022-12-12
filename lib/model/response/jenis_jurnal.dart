import 'package:equatable/equatable.dart';

class JenisJurnal extends Equatable {
  final int id_jurnal;
  final String kategori_jurnal;
  final String tipe_jurnal;

  const JenisJurnal({this.id_jurnal = 0, this.kategori_jurnal = "", this.tipe_jurnal = ""});

  factory JenisJurnal.fromJson(Map<String, dynamic> json) {
    return JenisJurnal(
        id_jurnal: json['id_jurnal'],
      kategori_jurnal: json['kategori_jurnal'],
      tipe_jurnal: json['tipe_jurnal']
    );
  }

  Map<String, dynamic> toJson() {
    return {'kategori_jurnal': this.kategori_jurnal, 'tipe_jurnal': this.tipe_jurnal};
  }

  @override
  List<Object> get props => [id_jurnal, kategori_jurnal, tipe_jurnal];
}
