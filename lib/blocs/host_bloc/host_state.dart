// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'host_bloc.dart';

sealed class HostState extends Equatable {
  const HostState();

  @override
  List<Object> get props => [];
}

final class HostInitial extends HostState {}

class LoadDetailHostState extends HostState {
  final Host host;
  LoadDetailHostState({
    required this.host,
  });
  
}
