import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';

class AkunState extends Equatable {
  const AkunState({this.status = SystemStatus.loading});

  final SystemStatus status;

  AkunState copyWith({
    SystemStatus? status,
  }) {
    return AkunState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
