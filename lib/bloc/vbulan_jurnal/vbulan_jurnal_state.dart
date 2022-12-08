import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';

class VBulanJurnalState extends Equatable {
  const VBulanJurnalState({
    this.status = SystemStatus.loading,
    this.list_bulan = const <VBulanJurnal>[]
  });

  final SystemStatus status;
  final List<VBulanJurnal> list_bulan;

  VBulanJurnalState copyWith({
    SystemStatus? status,
    List<VBulanJurnal>? list_bulan
  }) {
    return VBulanJurnalState(
        status: status ?? this.status,
        list_bulan: list_bulan ?? this.list_bulan
    );
  }

  @override
  List<Object?> get props => [status, list_bulan];
}