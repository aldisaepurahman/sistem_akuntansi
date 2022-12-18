import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class DetailAkunBloc extends Bloc<Event, SiakState> {
  DetailAkunBloc({required this.service}) : super(EmptyState()) {
    on<AkunDetailed>(_getDetail);
  }

  final SupabaseService service;

  Future<void> _getDetail(
      AkunDetailed event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.getDetailCOA(TableViewType.list_coa_saldo.name, {"kode_akun": event.kode}).then(
          (list_coa) {
            var coa = list_coa.datastore as VLookup;
        emit((list_coa.message.isEmpty)
                ? SuccessState(coa)
                : FailureState((list_coa.message.isNotEmpty)
                ? list_coa.message
                : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });

    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}
