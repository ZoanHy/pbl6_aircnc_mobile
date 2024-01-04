// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

class LoadReviewState extends ReviewState {
  final List<Review> lstReview;
  LoadReviewState({
    required this.lstReview,
  });
}


class LoadReviewHostState extends ReviewState {
  final List<ReviewHost> lstReviewHost;
  LoadReviewHostState({
    required this.lstReviewHost,
  });
}
