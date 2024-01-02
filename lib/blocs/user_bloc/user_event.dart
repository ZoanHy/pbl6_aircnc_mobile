// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserDetailEvent extends UserEvent {
  final int userId;
  LoadUserDetailEvent({
    required this.userId,
  });
}
