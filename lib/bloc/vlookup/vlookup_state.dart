import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';

class VLookupState extends Equatable {
  const VLookupState(
      {this.status = SystemStatus.loading, this.list_coa = const <VLookup>[]});

  final SystemStatus status;
  final List<VLookup> list_coa;

  VLookupState copyWith({SystemStatus? status, List<VLookup>? list_coa}) {
    return VLookupState(
        status: status ?? this.status, list_coa: list_coa ?? this.list_coa);
  }

  @override
  List<Object?> get props => [status, list_coa];
}
