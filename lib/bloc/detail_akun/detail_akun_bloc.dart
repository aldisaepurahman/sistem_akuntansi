import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/bloc/detail_akun/detail_akun_state.dart';
import 'package:sistem_akuntansi/bloc/vlookup/vlookup_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class DetailAkunBloc extends Bloc<Event, DetailAkunState> {
  DetailAkunBloc({required this.service}) : super(const DetailAkunState()) {
    on<AkunDetailed>(_getDetail);
  }

  final SupabaseService service;

  Future<void> _getDetail(
      AkunDetailed event, Emitter<DetailAkunState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      await service.getDetailCOA(TableViewType.list_coa_saldo.name, {"kode_akun": event.kode}).then(
          (list_coa) {
        emit(state.copyWith(
            status: (list_coa.message.isEmpty)
                ? SystemStatus.success
                : SystemStatus.failure,
            datastate: list_coa.datastore,
            error: (list_coa.message.isNotEmpty)
                ? list_coa.message
                : "tidak ada"));
      }).catchError((error) {
        emit(state.copyWith(
            status: SystemStatus.failure, error: error.toString()));
      });

    } catch (error) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}
