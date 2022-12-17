import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/laba_rugi/laba_rugi_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vneraca_lajur.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class LabaRugiBloc extends Bloc<Event, SiakState> {
  LabaRugiBloc({required this.service}) : super(EmptyState()) {
    on<LabaRugiFetched>(_fetchData);
  }

  final SupabaseService service;

  Future<void> _fetchData(
      LabaRugiFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getLabaRugi(
          TableViewType.v_neraca_lajur.name, {
        "bulan": event.bulan,
        "tahun": event.tahun
      })
          .then((laba_rugi) {
        var list_laba_rugi = List<VNeracaLajur>.from(laba_rugi.datastore);
        emit((laba_rugi.message.isEmpty)
            ? SuccessState(list_laba_rugi)
            : FailureState((laba_rugi.message.isNotEmpty)
            ? laba_rugi.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}