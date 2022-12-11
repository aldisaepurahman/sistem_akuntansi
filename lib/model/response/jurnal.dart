import 'package:equatable/equatable.dart';

class Jurnal extends Equatable {
  final int id_jurnal;
  final int id_jenis_jurnal;

  const Jurnal({this.id_jurnal = 0, required this.id_jenis_jurnal});

  factory Jurnal.fromJson(Map<String, dynamic> json) {
    return Jurnal(
        id_jurnal: json['id_jurnal'], id_jenis_jurnal: json['id_jenis_jurnal']);
  }

  Map<String, dynamic> toJson() {
    return {'id_jenis_jurnal': this.id_jenis_jurnal};
  }

  @override
  List<Object> get props => [id_jurnal, id_jenis_jurnal];
}
