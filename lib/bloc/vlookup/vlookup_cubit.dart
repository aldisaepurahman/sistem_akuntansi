import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VLookupCubit extends Cubit<VLookupState> {
  VLookupCubit({required this.service}) : super(const VLookupState()) {
    _getAllCoaData();
  }

  final SupabaseService service;

  Future<void> _getAllCoaData() async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      await service.getAllCOA(TableViewType.coa.name, {"nama_akun": ""}).then(
              (list_coa) {
            emit(state.copyWith(
                status: (list_coa.message.isEmpty)
                    ? SystemStatus.success
                    : SystemStatus.failure,
                list_coa: list_coa.datastore,
                error: (list_coa.message.isNotEmpty) ? list_coa.message : "tidak ada"));
          }).catchError((error) {
        emit(state.copyWith(status: SystemStatus.failure, error: error.toString()));
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
      emit(state.copyWith(status: SystemStatus.failure, error: error.toString()));
    }
  }

  void getSearchData(String keyword, List<Akun> data_akun) {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      final newList = data_akun.where((akun) => akun.nama_akun.contains(keyword)).toList();
      emit(state.copyWith(
          status: SystemStatus.success,
          list_coa: newList));
      // emit(SuccessState(data_akun.where((akun) => akun.nama_akun.contains(keyword)).toList()));
    } catch (error) {
        emit(state.copyWith(status: SystemStatus.failure, error: error.toString()));
    }
  }
}
