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
    on<LoadAllDetailPropertyEvent>(_onLoadAllDetailPropertyEvent);
  }

  FutureOr<void> _onLoadAllPropertyEvent(
      LoadAllPropertyEvent event, Emitter<PropertyState> emit) async {
    try {
      List<List<Property>> lstAllPageProperties =
          await PropertyRepo.getAllPagesProperty();
      List<Property> wishlistProperties = await WishlistRepo.getWishlists();

      for (List<Property> lstPropertiesPage in lstAllPageProperties) {
        for (Property property in lstPropertiesPage) {
          bool check =
              wishlistProperties.any((element) => element.id == property.id);

          if (check) {
            property.isFavorite = true;
          }
        }
      }
      emit(LoadingHomePageState());
      await Future.delayed(Duration(seconds: 2));
      emit(LoadAllPropertyState(lstAllPageProperties));
    } catch (e) {
      // Handle exceptions or errors here
      print('Error occurred: $e');
    }
  }

  FutureOr<void> _onLoadAllDetailPropertyEvent(
      LoadAllDetailPropertyEvent event, Emitter<PropertyState> emit) async {
    Property detailProperty =
        await PropertyRepo.getPropertyDetail(propertyId: event.propertyId);

    emit(LoadAllDetailPropertyState(detailProperty: detailProperty));
  }
}
