import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VJurnalBloc extends Bloc<Event, SiakState> {
  VJurnalBloc({required this.service}) : super(EmptyState()) {
    on<JurnalFetched>(_getAllTransaksi);
    on<JurnalInserted>(_insertData);
    on<JurnalDeleted>(_deleteData);
  }

  final SupabaseService service;

  Future<void> _getAllTransaksi(
      JurnalFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAllTransaksiJurnal(
          TableViewType.v_jurnal.name, {
        "bulan": event.bulan,
        "tahun": event.tahun,
        "id_jurnal": event.id_jurnal
      })
          .then((all_jurnal) {
        var list_jurnal = List<VJurnalExpand>.from(all_jurnal.datastore);
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

  Future<void> _insertData(JurnalInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.transaksi_utama.name, event.transaksiModel.toJson());
      await service.multiple_insert(TableViewType.transaksi_akun.name, event.transaksi_dk.map((dk) => dk.toJson()).toList());
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteData(JurnalDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service
          .delete(TableViewType.transaksi_akun.name, {"transaksi_utama_id_transaksi": event.id_transaksi});
      await service
          .delete(TableViewType.transaksi_utama.name, {"id_transaksi": event.id_transaksi});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
