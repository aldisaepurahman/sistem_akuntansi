import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VLookupBloc extends Bloc<Event, VLookupState> {
  VLookupBloc({required this.service}) : super(const VLookupState()) {
    on<AkunFetched>(_getAllCoaData);
  }

  final SupabaseService service;

  Future<void> _getAllCoaData(AkunFetched event, Emitter<VLookupState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      final list_coa = await service.getAllCOA(TableViewType.list_coa_saldo.name, {"nama_akun": "%${event.keyword}%"});
      emit(
          state.copyWith(
              status: SystemStatus.success,
              list_coa: list_coa
          )
      );
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}