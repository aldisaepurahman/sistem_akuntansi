import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VJurnalBloc extends Bloc<Event, VJurnalState> {
  VJurnalBloc({required this.service}) : super(const VJurnalState()) {
    on<JurnalFetched>(_getAllJurnal);
  }

  final SupabaseService service;

  Future<void> _getAllJurnal(
      JurnalFetched event, Emitter<VJurnalState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      final list_jurnal = await service.getAllJurnal(
          TableViewType.v_jurnal.name, {
        "bulan": event.bulan,
        "tahun": event.tahun,
        "id_jurnal": event.id_jurnal
      });
      emit(state.copyWith(
          status: SystemStatus.success, list_jurnal: list_jurnal));
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}
