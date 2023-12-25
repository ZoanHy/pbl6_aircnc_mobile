// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadAllWishlistEvent extends WishlistEvent {}

class ClickToLikeOrDislikeEvent extends WishlistEvent {
  final Property property;
  
  ClickToLikeOrDislikeEvent({
    required this.property,
  });


  @override
  List<Object> get props => [property];
}
