import 'package:equatable/equatable.dart';

abstract class SiakState extends Equatable {
  const SiakState();

  @override
  List<Object> get props => [];
}

class EmptyState extends SiakState {}

class LoadingState extends SiakState {}

class SuccessState extends SiakState {
  final dynamic datastore;

  const SuccessState(this.datastore);

  @override
  List<Object> get props => [datastore];
}

class FailureState extends SiakState {
  final String error;

  const FailureState(this.error);

  @override
  List<Object> get props => [error];
}