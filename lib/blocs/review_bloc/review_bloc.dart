import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/review.dart';
import 'package:pbl6_aircnc/models/review_host.dart';
import 'package:pbl6_aircnc/repositories/review_repo.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<LoadReviewEvent>(_onLoadReviewEvent);
    on<LoadReviewHostEvent>(_onLoadReviewHostEvent);
  }

  FutureOr<void> _onLoadReviewEvent(
      LoadReviewEvent event, Emitter<ReviewState> emit) async {
    List<Review> lstReview =
        await ReviewRepo.getAllReviewOfProperty(propertyId: event.propertyId);

    emit(LoadReviewState(lstReview: lstReview));
  }

  FutureOr<void> _onLoadReviewHostEvent(
      LoadReviewHostEvent event, Emitter<ReviewState> emit) async {
    List<ReviewHost> lstReviewHost =
        await ReviewRepo.getAllReviewOfHost(hostId: event.hostId);

    emit(LoadReviewHostState(lstReviewHost: lstReviewHost));
  }
}
