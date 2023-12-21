import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/repositories/property_repo.dart';
import 'package:pbl6_aircnc/repositories/wishlist_repo.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<LoadAllPropertyEvent>(_onLoadAllPropertyEvent);
  }

  FutureOr<void> _onLoadAllPropertyEvent(
      LoadAllPropertyEvent event, Emitter<PropertyState> emit) async {
    List<Property> lstAllProperties = await PropertyRepo.filterListProperties();
    List<Property> wishlistProperties = await WishlistRepo.getWishlists();

    for (Property property in wishlistProperties) {
      Property propertyInLstAll = lstAllProperties.firstWhere(
        (item) => item.id == property.id,
      );

      propertyInLstAll.isFavorite = true;
    }

    emit(LoadAllPropertyState(lstAllProperties));
  }
}
