import 'package:equatable/equatable.dart';

abstract class AkunEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AkunFetched extends AkunEvent {}