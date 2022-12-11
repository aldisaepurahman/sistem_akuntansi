import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VLookupBloc extends Bloc<Event, VLookupState> {
  VLookupBloc({required this.service}) : super(VLookupState()) {
    on<AkunFetched>(_getAllCoaData);
    on<AkunSearched>(_getAllCoaData);
  }

  final SupabaseService service;

  Future<void> _getAllCoaData(
      Event event, Emitter<VLookupState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      if (event is AkunFetched) {
        await service.getAllCOA(
            TableViewType.coa.name,
            {"nama_akun": ""})
            .then((list_coa) {
          emit(state.copyWith(
              status: (list_coa.message.isEmpty)
                  ? SystemStatus.success
                  : SystemStatus.failure,
              list_coa: list_coa.datastore,
              error: (list_coa.message.isNotEmpty) ? list_coa.message : "tidak ada"));
        })
            .catchError((error) {
          emit(state.copyWith(status: SystemStatus.failure, error: error.toString()));
        });
      } else if (event is AkunSearched) {
        await service.getAllCOA(
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
        });
      }

    } catch (error) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}
