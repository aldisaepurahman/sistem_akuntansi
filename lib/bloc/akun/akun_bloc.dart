import 'package:bloc/bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class AkunBloc extends Bloc<Event, SiakState> {
  AkunBloc({required this.service}) : super(EmptyState()) {
    on<AkunInserted>(_insertData);
    on<AkunUpdated>(_updateData);
    on<AkunDeleted>(_deleteData);
  }

  final SupabaseService service;

  Future<void> _insertData(AkunInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.coa.name, event.akun.toJson());
      await service.insert(TableViewType.coa_saldo.name, event.saldo.toJson());
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _updateData(AkunUpdated event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.update(TableViewType.coa.name, event.akun.toJson(),
          {"kode_akun": event.kode_akun});
      (event.id_saldo > 0)
          ? await service.update(TableViewType.coa_saldo.name,
              event.saldo.toJson(), {"id_saldo": event.id_saldo})
          : await service.insert(
              TableViewType.coa_saldo.name, event.saldo.toJson());
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteData(AkunDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service
          .delete(TableViewType.coa_saldo.name, {"kode_akun": event.kode_akun});
      await service
          .delete(TableViewType.coa.name, {"kode_akun": event.kode_akun});
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
