// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'host_bloc.dart';

sealed class HostEvent extends Equatable {
  const HostEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailHostEvent extends HostEvent {
  final int hostId;

  LoadDetailHostEvent({
    required this.hostId,
  });
}
