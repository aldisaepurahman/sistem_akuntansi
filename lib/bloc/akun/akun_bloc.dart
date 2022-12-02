import 'package:bloc/bloc.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_event.dart';
import 'package:sistem_akuntansi/bloc/akun/akun_state.dart';
import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';

class AkunBloc extends Bloc<AkunEvent, AkunState> {
  AkunBloc({required this.service}) : super(const AkunState()) {
    on<AkunFetched>(_getAllCoaData);
  }

  final SupabaseService service;

  Future<void> _getAllCoaData(AkunFetched event, Emitter<AkunState> emit) async {
    try {
      emit(state.copyWith(status: SystemStatus.loading));
      final list_coa = await service.getAllCOA();
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