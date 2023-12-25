part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

class LoadAllPropertyEvent extends PropertyEvent {}

class ClickToLikeOrDislikePropertyEvent extends PropertyEvent {}