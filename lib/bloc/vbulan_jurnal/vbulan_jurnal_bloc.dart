import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_event.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_state.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VBulanJurnalBloc extends Bloc<Event, VBulanJurnalState> {
  VBulanJurnalBloc({required this.service}) : super(const VBulanJurnalState()) {
    on<BulanFetched>(_getAllJurnal);
  }

  final SupabaseService service;

  Future<void> _getAllJurnal(
      BulanFetched event, Emitter<VBulanJurnalState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      final list_bulan = await service.getAllBulan(
          TableViewType.v_bulan_jurnal.name,
          {"bulan": event.bulan, "tahun": event.tahun});
      emit(
          state.copyWith(status: SystemStatus.success, list_bulan: list_bulan));
    } catch (_) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}
