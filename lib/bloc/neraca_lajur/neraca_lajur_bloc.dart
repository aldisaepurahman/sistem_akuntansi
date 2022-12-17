import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/neraca_lajur/neraca_lajur_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vneraca_lajur.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class NeracaLajurBloc extends Bloc<Event, SiakState> {
  NeracaLajurBloc({required this.service}) : super(EmptyState()) {
    on<NeracaLajurFetched>(_fetchData);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      NeracaLajurFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getNeracaLajur(
          TableViewType.v_neraca_lajur.name, {
        "bulan": event.bulan,
        "tahun": event.tahun
      })
          .then((neraca) {
        var list_neraca = List<VNeracaLajur>.from(neraca.datastore);
        emit((neraca.message.isEmpty)
            ? SuccessState(list_neraca)
            : FailureState((neraca.message.isNotEmpty)
            ? neraca.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}