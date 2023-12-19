part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object> get props => [];
}

final class PropertyInitial extends PropertyState {}

class LoadAllPropertyState extends PropertyState {
  final List<Property> properties;

  const LoadAllPropertyState(this.properties);

  @override
  List<Object> get props => [properties];
}
