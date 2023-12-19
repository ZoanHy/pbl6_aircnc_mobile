import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/repositories/property_repo.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<LoadAllPropertyEvent>(_onLoadAllPropertyEvent);
  }

  FutureOr<void> _onLoadAllPropertyEvent(
      LoadAllPropertyEvent event, Emitter<PropertyState> emit) async {
    List<Property> lstAllProperty = await PropertyRepo.filterListProperties();
    print(lstAllProperty.length);
    emit(LoadAllPropertyState(lstAllProperty));
  }
}
