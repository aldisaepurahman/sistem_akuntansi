import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/vbulan_jurnal/vbulan_jurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class VBulanJurnalBloc extends Bloc<Event, SiakState> {
  VBulanJurnalBloc({required this.service}) : super(EmptyState()) {
    on<BulanFetched>(_getAllJurnal);
  }

  final SupabaseService service;

  Future<void> _getAllJurnal(
      BulanFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getAllBulan(
          TableViewType.v_bulan_jurnal.name, {
        "month": event.bulan,
        "year": event.tahun
      })
      .then((months) {
        var list_bulan = List<VBulanJurnal>.from(months.datastore);
        var filtered_bulan = list_bulan.where((bulan) => bulan.bulan > 0).toList();
        emit((months.message.isEmpty)
            ? SuccessState(filtered_bulan)
            : FailureState((months.message.isNotEmpty)
            ? months.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
