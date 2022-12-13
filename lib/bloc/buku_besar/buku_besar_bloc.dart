import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/buku_besar/buku_besar_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class BukuBesarBloc extends Bloc<Event, SiakState> {
  BukuBesarBloc({required this.service}) : super(EmptyState()) {
    on<BukuBesarFetched>(_fetchData);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      BukuBesarFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getBukuBesar(
          TableViewType.v_jurnal.name, {
        "bulan": event.bulan,
        "tahun": event.tahun,
        "coa_kode_akun": event.kode_akun
      })
          .then((all_jurnal) {
        var list_jurnal = List<VJurnalExpand>.from(all_jurnal.datastore);
        emit((all_jurnal.message.isEmpty)
            ? SuccessState(list_jurnal)
            : FailureState((all_jurnal.message.isNotEmpty)
            ? all_jurnal.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}