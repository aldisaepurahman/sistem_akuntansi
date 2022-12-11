import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';

abstract class DataState extends Equatable {

const DataState({
    this.status = SystemStatus.loading,
    this.datastate = 0,
    this.error = ""
  });

  final SystemStatus status;
  final dynamic datastate;
  final String error;

  @override
  List<Object?> get props => [status, datastate, error];

}