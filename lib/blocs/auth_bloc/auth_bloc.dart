import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthAppStartedEvent>(_onAuthAppStartedEvent);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignOutEvent>(_onAuthSignOutEvent);
    on<AuthInitEvent>(_onAuthInitEvent);
  }

  FutureOr<void> _onAuthAppStartedEvent(
      AuthAppStartedEvent event, Emitter<AuthState> emit) {
    emit(AunthenticateUninitializedState());
  }

  FutureOr<void> _onAuthSignIn(
      AuthSignIn event, Emitter<AuthState> emit) async {
    User? user = await AuthRepo.signIn(event.email, event.password);
    print(user);

    if (user != null) {
      emit(AunthenticateInitializedState(user: user));
    } else {
      print('emit error');
      emit(AuthErrorState());
      emit(AunthenticateUninitializedState());
    }
  }

  FutureOr<void> _onAuthSignOutEvent(
      AuthSignOutEvent event, Emitter<AuthState> emit) async {
    await AuthRepo.deleteAllTokenWhenLogout();

    emit(AunthenticateUninitializedState());
  }

  FutureOr<void> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    String result = await AuthRepo.signUp(
        username: event.username,
        fullName: event.fullName,
        email: event.email,
        password: event.password);

    if (result == 'ok') {
      emit(AuthSignUpSuccessState());
    } else {
      emit(AuthSignUpFailedState(errorMessage: result));
    }
  }

  FutureOr<void> _onAuthInitEvent(
      AuthInitEvent event, Emitter<AuthState> emit) async {
    emit(AunthenticateInitializedState(user: event.user));
  }
}
