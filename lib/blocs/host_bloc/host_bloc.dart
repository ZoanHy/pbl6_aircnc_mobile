import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/host.dart';
import 'package:pbl6_aircnc/repositories/host_repo.dart';

part 'host_event.dart';
part 'host_state.dart';

class HostBloc extends Bloc<HostEvent, HostState> {
  HostBloc() : super(HostInitial()) {
    on<LoadDetailHostEvent>(_onLoadDetailHostEvent);
  }

  FutureOr<void> _onLoadDetailHostEvent(
      LoadDetailHostEvent event, Emitter<HostState> emit) async {
    Host host = await HostRepo.getHostDetail(hostId: event.hostId);

    emit(LoadDetailHostState(host: host));
  }
}
