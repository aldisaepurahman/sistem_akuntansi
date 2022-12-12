import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/jenisjurnal/jenisjurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class JenisJurnalBloc extends Bloc<Event, SiakState> {
  JenisJurnalBloc({required this.service}) : super(EmptyState()) {
    on<JenisJurnalFetched>(_getAllJurnal);
    on<JenisJurnalInserted>(_insertData);
  }

  final SupabaseService service;

  Future<void> _getAllJurnal(
      JenisJurnalFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAllJurnal(
          TableViewType.jurnal_umum.name, {"tipe_jurnal": event.tipe})
          .then((all_jurnal) {
        var list_jurnal = List<JenisJurnal>.from(all_jurnal.datastore);
        emit((all_jurnal.message.isEmpty)
            ? SuccessState(list_jurnal)
            : FailureState((all_jurnal.message.isNotEmpty)
            ? all_jurnal.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _insertData(JenisJurnalInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.jurnal_umum.name, event.jenis_jurnal.toJson());
      emit(const SuccessState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}