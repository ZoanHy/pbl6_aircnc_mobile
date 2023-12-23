// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AunthenticateUninitializedState extends AuthState {}

class AunthenticateInitializedState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthSignInSuccessState extends AuthState {
  final User user;

  AuthSignInSuccessState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthSignInStatusState extends AuthState {
  final bool status;

  AuthSignInStatusState({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}

class AuthSignUpSuccessState extends AuthState {}

class AuthSignUpFailedState extends AuthState {
  final String errorMessage;

  AuthSignUpFailedState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class AuthLoadingState extends AuthState {}
