part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object> get props => [];
}

final class PropertyInitial extends PropertyState {}

class LoadAllPropertyState extends PropertyState {
  final List<List<Property>> propertiesPage;

  const LoadAllPropertyState(this.propertiesPage);

  @override
  List<Object> get props => [propertiesPage];
}

class LikeOrDislikePropertyState extends PropertyState {}
