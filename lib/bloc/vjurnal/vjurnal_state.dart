import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';

class VJurnalState extends Equatable {
  const VJurnalState({
    this.status = SystemStatus.loading,
    this.list_jurnal = const <VJurnal>[]
  });

  final SystemStatus status;
  final List<VJurnal> list_jurnal;

  VJurnalState copyWith({
    SystemStatus? status,
    List<VJurnal>? list_jurnal
  }) {
    return VJurnalState(
        status: status ?? this.status,
        list_jurnal: list_jurnal ?? this.list_jurnal
    );
  }

  @override
  List<Object?> get props => [status, list_jurnal];
}