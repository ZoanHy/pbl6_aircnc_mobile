// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

final class WishlistInitial extends WishlistState {}

class LoadAllWishlistState extends WishlistState {
  final List<List<Property>> wishlistPropertiesPage;
  LoadAllWishlistState({
    required this.wishlistPropertiesPage,
  });

  @override
  List<Object> get props => [wishlistPropertiesPage];
}

class LikeOrDislikeState extends WishlistState {}
