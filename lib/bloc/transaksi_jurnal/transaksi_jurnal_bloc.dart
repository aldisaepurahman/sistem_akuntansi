import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/transaksi_jurnal/transaksi_jurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class TransaksiJurnalBloc extends Bloc<Event, SiakState> {
  TransaksiJurnalBloc({required this.service}) : super(EmptyState()) {
    // on<TransaksiInserted>(_insertData);
    /*on<JenisJurnalUpdated>(_updateData);
    on<JenisJurnalDeleted>(_deleteData);*/
  }

  final SupabaseService service;

  /*Future<void> _insertData(TransaksiInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.transaksi_utama.name, event.transaksiModel.toJson());
      await service.multiple_insert(TableViewType.transaksi_akun.name, event.transaksi_dk.map((dk) => dk.toJson()).toList());
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }*/

  /*Future<void> _updateData(JenisJurnalUpdated event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.update(TableViewType.jurnal_umum.name, event.jenis_jurnal.toJson(), {"id_jurnal": event.id_jurnal});
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteData(JenisJurnalDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.delete(TableViewType.jurnal_umum.name, {"id_jurnal": event.id_jurnal});
      emit(const CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }*/
}