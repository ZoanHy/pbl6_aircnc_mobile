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
    on<ClickToLikeOrDislikeEvent>(_onClickToLikeOrDislikeEvent);
  }

  FutureOr<void> _onLoadAllWishlistEvent(
      LoadAllWishlistEvent event, Emitter<WishlistState> emit) async {
    List<List<Property>> wishlistPropertiesPage =
        await WishlistRepo.getAllPagesWishlist();

    emit(LoadAllWishlistState(wishlistPropertiesPage: wishlistPropertiesPage));
  }

  FutureOr<void> _onClickToLikeOrDislikeEvent(
      ClickToLikeOrDislikeEvent event, Emitter<WishlistState> emit) async {
    bool check;
    if (event.property.isFavorite) {
      check = await WishlistRepo.removeAPropertyToWishlists(
          event.property.id.toString());
    } else {
      check = await WishlistRepo.addAPropertyToWishlists(
          event.property.id.toString());
    }

    print('ok');
  }
}
