import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_aset/amortisasi_aset_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset_detail.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class AmortisasiAsetBloc extends Bloc<Event, SiakState> {
  AmortisasiAsetBloc({required this.service}): super(EmptyState()) {
    on<AmortisasiAsetFetched>(_fetchData);
    on<AmortisasiAsetDetailFetched>(_getDetail);
    on<AmortisasiAsetInserted>(_insertDataAset);
    on<AmortisasiDetailAsetInserted>(_insertDataDetail);
    on<AmortisasiAsetUpdated>(_updateDataAset);
    on<AmortisasiAsetDeleted>(_deleteDataAset);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      AmortisasiAsetFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAmortisasiAset(
          TableViewType.amortisasi_aset.name, {
        "tahun": event.tahun,
        "id_amortisasi_akun": event.id_amortisasi_akun
      })
          .then((asset) {
        var list_aset = List<AmortisasiAset>.from(asset.datastore);
        emit((asset.message.isEmpty)
            ? SuccessState(list_aset)
            : FailureState((asset.message.isNotEmpty)
            ? asset.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _getDetail(
      AmortisasiAsetDetailFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getDetailAmortisasiAset(
          TableViewType.amortisasi_aset_detail.name, {
        "id_amortisasi_aset": event.id_amortisasi_aset
      })
          .then((asset) {
        var list_aset = asset.datastore as AmortisasiAsetDetail;
        emit((asset.message.isEmpty)
            ? SuccessState(list_aset)
            : FailureState((asset.message.isNotEmpty)
            ? asset.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _insertDataAset(AmortisasiAsetInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.amortisasi_aset.name, event.aset.toJson());
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _insertDataDetail(AmortisasiDetailAsetInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.amortisasi_aset_detail.name, event.aset_detail.toJson());
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _updateDataAset(AmortisasiAsetUpdated event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.update(TableViewType.amortisasi_aset.name, event.aset.toJson(),
          {"id_amortisasi_aset": event.id_amortisasi_aset});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteDataAset(AmortisasiAsetDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service
          .delete(TableViewType.amortisasi_aset_detail.name, {"id_amortisasi_aset": event.id_amortisasi_aset});
      await service
          .delete(TableViewType.amortisasi_aset.name, {"id_amortisasi_aset": event.id_amortisasi_aset});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}