// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

sealed class AuthActionState extends AuthState {}

class AunthenticateUninitializedState extends AuthState {}

class AunthenticateInitializedState extends AuthState {}

class AuthErrorState extends AuthActionState {}

class AuthSignInActionState extends AuthActionState {
  final User user;

  AuthSignInActionState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
