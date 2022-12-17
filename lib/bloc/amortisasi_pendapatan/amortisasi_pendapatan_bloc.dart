import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/amortisasi_pendapatan/amortisasi_pendapatan_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan_detail.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class AmortisasiPendapatanBloc extends Bloc<Event, SiakState> {
  AmortisasiPendapatanBloc({required this.service}): super(EmptyState()) {
    on<AmortisasiPendapatanFetched>(_fetchData);
    on<AmortisasiPendapatanDetailFetched>(_getDetail);
    on<AmortisasiPendapatanInserted>(_insertDataPendapatan);
    on<AmortisasiDetailPendapatanInserted>(_insertDataDetail);
    on<AmortisasiPendapatanUpdated>(_updateDataPendapatan);
    on<AmortisasiDetailPendapatanUpdated>(_updateDetailDataPendapatan);
    on<AmortisasiPendapatanDeleted>(_deleteDataPendapatan);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      AmortisasiPendapatanFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAmortisasiPendapatan(
          TableViewType.amortisasi_pendapatan.name, {
        "semester": event.semester,
        "id_amortisasi_akun": event.id_amortisasi_akun
      })
          .then((asset) {
        var list_Pendapatan = List<AmortisasiPendapatan>.from(asset.datastore);
        emit((asset.message.isEmpty)
            ? SuccessState(list_Pendapatan)
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
      AmortisasiPendapatanDetailFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getDetailAmortisasiPendapatan(
          TableViewType.amortisasi_pendapatan_detail.name, {
        "id_amortisasi_pendapatan": event.id_amortisasi_pendapatan,
        "tahun": DateTime.now().year
      })
          .then((asset) {
        var list_Pendapatan = List<AmortisasiPendapatanDetail>.from(asset.datastore);
        emit((asset.message.isEmpty)
            ? SuccessState(list_Pendapatan)
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

  Future<void> _insertDataPendapatan(AmortisasiPendapatanInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.amortisasi_pendapatan.name, event.pendapatan.toJson());
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _insertDataDetail(AmortisasiDetailPendapatanInserted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.insert(TableViewType.amortisasi_pendapatan_detail.name, event.pendapatan_detail.toJson());
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _updateDataPendapatan(AmortisasiPendapatanUpdated event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.update(TableViewType.amortisasi_pendapatan.name, event.pendapatan.toJson(),
          {"id_amortisasi_pendapatan": event.id_amortisasi_pendapatan});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _updateDetailDataPendapatan(AmortisasiDetailPendapatanUpdated event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.update(TableViewType.amortisasi_pendapatan_detail.name, event.pendapatan_detail.toJson(),
          {"id_pendapatan_detail": event.id_amortisasi_detail});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _deleteDataPendapatan(AmortisasiPendapatanDeleted event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service
          .delete(TableViewType.amortisasi_pendapatan_detail.name, {"id_amortisasi_pendapatan": event.id_amortisasi_pendapatan});
      await service
          .delete(TableViewType.amortisasi_pendapatan.name, {"id_amortisasi_pendapatan": event.id_amortisasi_pendapatan});
      emit(CrudState(true));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}