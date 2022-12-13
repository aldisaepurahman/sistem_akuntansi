import 'package:equatable/equatable.dart';

class JenisJurnalModel extends Equatable {
  int id_jurnal;
  String kategori_jurnal;
  String tipe_jurnal;

  JenisJurnalModel({this.id_jurnal = 0, this.kategori_jurnal = "", this.tipe_jurnal = ""});

  factory JenisJurnalModel.fromJson(Map<String, dynamic> json) {
    return JenisJurnalModel(
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
