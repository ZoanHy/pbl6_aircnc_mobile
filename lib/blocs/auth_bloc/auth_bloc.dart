import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/repositories/auth_repo.dart';
import 'package:pbl6_aircnc/screens/home_screen.dart';
import 'package:pbl6_aircnc/screens/profile_screen.dart';
import 'package:pbl6_aircnc/screens/sign_in_screen.dart';
import 'package:pbl6_aircnc/screens/wishlist_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthAppStartedEvent>(_onAuthAppStartedEvent);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthSignOutEvent>(_onAuthSignOutEvent);
  }

  FutureOr<void> _onAuthAppStartedEvent(
      AuthAppStartedEvent event, Emitter<AuthState> emit) {
    emit(AunthenticateUninitializedState());
  }

  FutureOr<void> _onAuthSignIn(
      AuthSignIn event, Emitter<AuthState> emit) async {
    User? user = await AuthRepo.signIn(event.email, event.password);
    if (user != null) {
      emit(AuthLoadingState());

      await Future.delayed(Duration(seconds: 2));

      emit(AuthSignInActionState(user: user));
      // emit(AunthenticateInitializedState(user: user));
    } else {
      print('emit error');
      emit(AunthenticateUninitializedState());
      emit(AuthErrorState());
    }
  }

  FutureOr<void> _onAuthSignOutEvent(
      AuthSignOutEvent event, Emitter<AuthState> emit) async {
    await AuthRepo.deleteAllTokenWhenLogout();

    emit(AunthenticateUninitializedState());
  }
}
