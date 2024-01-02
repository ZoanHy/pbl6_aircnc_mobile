// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'property_bloc.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyActionState extends PropertyState {}

class LoadAllPropertyState extends PropertyState {
  final List<List<Property>> propertiesPage;

  const LoadAllPropertyState(this.propertiesPage);

  @override
  List<Object> get props => [propertiesPage];
}

class LikeOrDislikePropertyState extends PropertyState {}

class LoadAllDetailPropertyState extends PropertyState {
  final Property detailProperty;

  LoadAllDetailPropertyState({
    required this.detailProperty,
  });
}

class LoadingHomePageState extends PropertyState {}
