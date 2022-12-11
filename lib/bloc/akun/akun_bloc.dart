import 'package:bloc/bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_event.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_state.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class AkunBloc extends Bloc<Event, AkunState> {
  AkunBloc({required this.service}) : super(const AkunState()) {
    on<AkunInserted>(_insertData);
    on<AkunUpdated>(_updateData);
    on<AkunDeleted>(_deleteData);
  }

  final SupabaseService service;

  Future<void> _insertData(AkunInserted event, Emitter<AkunState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      await service.insert(TableViewType.coa.name, event.akun.toJson());
      await service.insert(TableViewType.coa_saldo.name, event.saldo.toJson());
      emit(state.copyWith(status: SystemStatus.success));
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }

  Future<void> _updateData(AkunUpdated event, Emitter<AkunState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      await service.update(TableViewType.coa.name, event.akun.toJson(), {"kode_akun": event.akun.kode_akun});
      await service.update(TableViewType.coa_saldo.name, event.saldo.toJson(), {"id_saldo": event.saldo.id_saldo});
      emit(state.copyWith(status: SystemStatus.success));
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }

  Future<void> _deleteData(AkunDeleted event, Emitter<AkunState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      await service.delete(TableViewType.coa.name, {"kode_akun": event.kode_akun});
      await service.delete(TableViewType.coa_saldo.name, {"kode_akun": event.kode_akun});
      emit(state.copyWith(status: SystemStatus.success));
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}