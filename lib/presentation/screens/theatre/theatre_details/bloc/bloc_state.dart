import 'package:equatable/equatable.dart';

abstract class TheatreDetailsStates extends Equatable {
  const TheatreDetailsStates();
  @override
  List<Object> get props => [];
}

class ImageContainerSelectedStateInitial extends TheatreDetailsStates {
  const ImageContainerSelectedStateInitial();
  @override
  List<Object> get props => [];
}

class ImageContainerSelectedState extends TheatreDetailsStates {
  final int index;
  final String imageUrl;
  const ImageContainerSelectedState(this.index,this.imageUrl);
  @override
  List<Object> get props => [index,imageUrl];
}
