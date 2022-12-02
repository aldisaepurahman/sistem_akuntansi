import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/akun/akun.dart';

class AkunState extends Equatable {
  const AkunState({
    this.status = SystemStatus.loading,
    this.list_coa = const <Akun>[]
  });

  final SystemStatus status;
  final List<Akun> list_coa;

  AkunState copyWith({
    SystemStatus? status,
    List<Akun>? list_coa
  }) {
    return AkunState(
      status: status ?? this.status,
      list_coa: list_coa ?? this.list_coa
    );
  }

  @override
  List<Object> get props => [status, list_coa];

}