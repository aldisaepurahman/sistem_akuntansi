import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VLookupBloc extends Bloc<Event, SiakState> {
  VLookupBloc({required this.service}) : super(EmptyState()) {
    on<AkunFetched>(_getAllCoaData);
    on<AkunSearched>(_getSearchData);
  }

  final SupabaseService service;

  Future<void> _getAllCoaData(
      Event event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAllCOA(TableViewType.coa.name, {"nama_akun": ""}).then(
          (list_coa) {
            var list_akun = List<Akun>.from(list_coa.datastore);
            var filtered_akun = list_akun.where((coa) => coa.keterangan_akun != "Header").toList();
        emit((list_coa.message.isEmpty)
            ? SuccessState(filtered_akun)
            : FailureState((list_coa.message.isNotEmpty)
                ? list_coa.message
                : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
      /*if (event is AkunFetched) {
      } else if (event is AkunSearched) {*/
        /*emit(state.copyWith(
            status: SystemStatus.success,
            list_coa: event.data_akun.where((akun) => akun.nama_akun.contains(event.keyword)).toList()));*/
        /*await service.getAllCOA(
            TableViewType.coa.name,
            {"nama_akun": event.keyword})
            .then((list_coa) {
          emit(state.copyWith(
              status: (list_coa.message.isEmpty)
                  ? SystemStatus.success
                  : SystemStatus.failure,
              list_coa: list_coa.datastore,
              error: (list_coa.message.isNotEmpty) ? list_coa.message : event.keyword));
        })
            .catchError((error) {
          emit(state.copyWith(status: SystemStatus.failure, error: error.toString()));
        });*/
      // }

    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }

  Future<void> _getSearchData(AkunSearched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      final list_coa = await event.data_akun.where((akun) => akun.nama_akun.contains(event.keyword)).toList();
      emit(SuccessState(list_coa));
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
