import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/user_detail.dart';
import 'package:pbl6_aircnc/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<LoadUserDetailEvent>(_onLoadUserDetailEvent);
  }

  FutureOr<void> _onLoadUserDetailEvent(
      LoadUserDetailEvent event, Emitter<UserState> emit) async {
    UserDetail userDetail = await UserRepo.getUserDetail(event.userId);
    emit(LoadUserDetailState(userDetail: userDetail));
  }
}
