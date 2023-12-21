import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/repositories/wishlist_repo.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<LoadAllWishlistEvent>(_onLoadAllWishlistEvent);
  }

  FutureOr<void> _onLoadAllWishlistEvent(
      LoadAllWishlistEvent event, Emitter<WishlistState> emit) async {
    List<Property> wishlistProperty = await WishlistRepo.getWishlists();

    print(wishlistProperty);

    emit(LoadAllWishlistState(wishlistProperty: wishlistProperty));
  }
}
