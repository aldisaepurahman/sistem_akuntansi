import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/DataState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';

class DetailAkunState extends DataState {
  const DetailAkunState({
    this.status = SystemStatus.loading,
    this.datastate = 0,
    this.error = ""
  }) : super(status: status, datastate: datastate, error: error);

  final SystemStatus status;
  final dynamic datastate;
  final String error;

  DetailAkunState copyWith({
    SystemStatus? status,
    VLookup? datastate,
    String? error
  }) {
    return DetailAkunState(
        status: status ?? this.status,
        datastate: datastate ?? this.datastate,
        error: error ?? this.error
    );
  }

}