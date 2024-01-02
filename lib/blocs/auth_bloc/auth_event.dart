// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStartedEvent extends AuthEvent {}

class AuthInitEvent extends AuthEvent {
  final User user;
  AuthInitEvent({
    required this.user,
  });

  
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String fullName;
  final String email;
  final String username;
  final String password;

  AuthSignUp(
      {required this.fullName,
      required this.email,
      required this.username,
      required this.password});

  @override
  List<Object> get props => [fullName, email, username, password];
}

class AuthSignOutEvent extends AuthEvent {}
