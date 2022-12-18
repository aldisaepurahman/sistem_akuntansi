import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/login/login_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/users.dart';
import 'package:sistem_akuntansi/utils/table_view.dart';

class LoginBloc extends Bloc<Event, SiakState> {
  LoginBloc({required this.service}) : super(EmptyState()) {
    on<LoginFetched>(_signIn);
  }

  final SupabaseService service;

  Future<void> _signIn(
      LoginFetched event, Emitter<SiakState> emit) async {
    try {
      emit(LoadingState());
      await service.signIn(
          TableViewType.stibo_users.name, event.email, event.password)
          .then((userdata) {
        var user = userdata.datastore as Users;
        emit((userdata.message.isEmpty)
            ? SuccessState(user)
            : FailureState((userdata.message.isNotEmpty)
            ? userdata.message
            : "tidak ada"));
      }).catchError((error) {
        emit(FailureState(error.toString()));
      });
    } catch (error) {
      emit(FailureState(error.toString()));
    }
  }
}