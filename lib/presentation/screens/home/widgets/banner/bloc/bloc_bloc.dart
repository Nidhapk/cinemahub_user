import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final int totalImages = 3;
  Timer? _timer;

  // Initialize with BannerImageChangedState and set currentPage to 0
  BannerBloc() : super(const BannerImageChangedState(currentPage: 0)) {
    on<BannerImageChangedEvent>(onImageChanged);
    on<BannerNextPageEvent>(onNextPageEvent); // Make sure the event is handled
    // startImageSlider(); // Start the automatic page slider
  }

  // When image is manually changed
  void onImageChanged(
      BannerImageChangedEvent event, Emitter<BannerState> emit) {
    emit(BannerImageChangedState(currentPage: event.index));
  }

  // Automatically change the banner page
  void onNextPageEvent(BannerNextPageEvent event, Emitter<BannerState> emit) {
    // Ensure we are in a valid state that has currentPage information
    if (state is BannerImageChangedState) {
      final currentState = state as BannerImageChangedState;
      final nextIndex = (currentState.currentPage + 1) % totalImages;

      emit(BannerImageChangedState(currentPage: nextIndex));
    }
  }

  // Start the automatic image slider using a periodic timer
  void startImageSlider() {
    log('timer');
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      add(const BannerNextPageEvent());
      //  add(BannerImageChangedEvent(index: 1));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Cancel the timer when Bloc is closed
    return super.close();
  }
}
