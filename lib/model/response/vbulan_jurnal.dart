import 'package:equatable/equatable.dart';

class VBulanJurnal extends Equatable {
  final int bulan;
  final int tahun;

  const VBulanJurnal({required this.bulan, required this.tahun});

  factory VBulanJurnal.fromJson(Map<String, dynamic> json) {
    return VBulanJurnal(bulan: json['bulan'], tahun: json['tahun']);
  }

  @override
  List<Object?> get props => [bulan, tahun];
}