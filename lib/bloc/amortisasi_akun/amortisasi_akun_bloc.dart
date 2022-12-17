import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_akun/amortisasi_akun_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class AmortisasiAkunBloc extends Bloc<Event, SiakState> {
  AmortisasiAkunBloc({required this.service}): super(EmptyState()) {
    on<AmortisasiAkunFetched>(_fetchData);
    on<AmortisasiAkunInserted>(_insertData);
    on<AmortisasiAkunDeleted>(_deleteData);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      AmortisasiAkunFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAmortisasiAkun(
          TableViewType.amortisasi_akun.name)
          .then((accounts) {
        var list_akun = List<AmortisasiAkun>.from(accounts.datastore);
        emit((accounts.message.isEmpty)
            ? SuccessState(list_akun)
            : FailureState((accounts.message.isNotEmpty)
            ? accounts.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _insertData(AmortisasiAkunInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.amortisasi_akun.name, event.akun.toJson());
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteData(AmortisasiAkunDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service
          .delete(TableViewType.amortisasi_aset.name, {"id_amortisasi_akun": event.id_amortisasi_akun});
      await service
          .delete(TableViewType.amortisasi_pendapatan.name, {"id_amortisasi_akun": event.id_amortisasi_akun});
      await service
          .delete(TableViewType.amortisasi_akun.name, {"id_amortisasi_akun": event.id_amortisasi_akun});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}