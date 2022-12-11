import 'package:equatable/equatable.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/saldo.dart';

class AkunInserted extends Event {
  final Akun akun;
  final Saldo saldo;

  AkunInserted({required this.akun, required this.saldo});
}
class AkunUpdated extends Event {
  final Akun akun;
  final Saldo saldo;
  final String kode_akun;
  final int id_saldo;

  AkunUpdated({required this.akun, required this.saldo, required this.kode_akun, required this.id_saldo});
}
class AkunDeleted extends Event {
  final String kode_akun;

  AkunDeleted({required this.kode_akun});
}