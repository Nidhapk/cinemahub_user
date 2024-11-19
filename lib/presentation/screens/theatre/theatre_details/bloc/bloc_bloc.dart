import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_state.dart';

class TheatreDeatilsBloc
    extends Bloc<TheatreDetailsEvent, TheatreDetailsStates> {
  TheatreDeatilsBloc() : super(const ImageContainerSelectedStateInitial()) {
    on<ImageContainerTapedEvent>(containerOntap);
  }
  void containerOntap(
      ImageContainerTapedEvent event, Emitter<TheatreDetailsStates> emit) {
    emit(
      ImageContainerSelectedState(event.index, event.imageUrl),
    );
  }
}
