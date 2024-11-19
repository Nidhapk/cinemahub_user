import 'package:equatable/equatable.dart';

abstract class TheatreDetailsEvent extends Equatable {
  const TheatreDetailsEvent();
  @override
  List<Object> get props => [];
}

class ImageContainerTapedEvent extends TheatreDetailsEvent {
  final int index;
  final String imageUrl;
  const ImageContainerTapedEvent(this.index,this.imageUrl);
  @override
  List<Object> get props => [index,imageUrl];
}