import 'package:equatable/equatable.dart';

abstract class BannerState extends Equatable {
  const BannerState();
  @override
  List<Object> get props => [];
}

class BannerInitialState extends BannerState {
  final int currentPage;
  const BannerInitialState({this.currentPage = 0});
  @override
  List<Object> get props => [ currentPage];
}

class BannerImageChangedState extends BannerState {
   final int currentPage;
  const BannerImageChangedState({required this.currentPage});
  @override
  List<Object> get props => [currentPage];
}
