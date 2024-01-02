// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

class UserState extends Equatable {
  UserState();

  @override
  List<Object> get props => [];
}

class LoadUserDetailState extends UserState {
  final UserDetail userDetail;
  LoadUserDetailState({
    required this.userDetail,
  });
}
