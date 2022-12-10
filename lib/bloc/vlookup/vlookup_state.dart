import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/DataState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';

class VLookupState extends DataState {
  const VLookupState({
    this.status = SystemStatus.loading,
    this.list_coa = const <Akun>[],
    this.error = ""
  }) : super(status: status, datastate: list_coa, error: error);

  final SystemStatus status;
  final List<Akun> list_coa;
  final String error;
  /*const VLookupState({
    this.status = SystemStatus.loading,
    this.list_coa = const <Akun>[],
    this.error = ""
  });

  final SystemStatus status;
  final List<Akun> list_coa;
  final String error;*/

  VLookupState copyWith({
    SystemStatus? status,
    List<Akun>? list_coa,
    String? error
  }) {
    return VLookupState(
      status: status ?? this.status,
      list_coa: list_coa ?? this.list_coa,
      error: error ?? this.error
    );
  }
/*
  @override
  List<Object?> get props => [status, list_coa, error];*/

}