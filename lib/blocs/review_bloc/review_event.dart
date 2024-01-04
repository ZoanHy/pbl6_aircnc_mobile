// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class LoadReviewEvent extends ReviewEvent {
  final int propertyId;
  LoadReviewEvent({
    required this.propertyId,
  });
}

class LoadReviewHostEvent extends ReviewEvent {
  final int hostId;
  LoadReviewHostEvent({
    required this.hostId,
  });
}
