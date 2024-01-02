// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'property_bloc.dart';

sealed class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object> get props => [];
}

class LoadAllPropertyEvent extends PropertyEvent {}

class ClickToLikeOrDislikePropertyEvent extends PropertyEvent {}

class LoadAllDetailPropertyEvent extends PropertyEvent {
  final int propertyId;
  
  LoadAllDetailPropertyEvent({
    required this.propertyId,
  });
  
}
