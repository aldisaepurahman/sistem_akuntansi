import 'package:equatable/equatable.dart';

class VBulanJurnal extends Equatable {
  final int bulan;
  final int tahun;

  const VBulanJurnal({this.bulan = 0, this.tahun = 0});

  factory VBulanJurnal.fromJson(Map<String, dynamic> json) {
    return VBulanJurnal(bulan: json['month'] ?? 0, tahun: json['year'] ?? 0);
  }

  @override
  List<Object?> get props => [bulan, tahun];
}