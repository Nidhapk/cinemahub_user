import 'package:equatable/equatable.dart';

abstract class MybookingsEvent extends Equatable {
  const MybookingsEvent();
  @override
  List<Object> get props => [];
}

class FetchMyBookings extends MybookingsEvent {
  final String userId;
  const FetchMyBookings(this.userId);
  @override
  List<Object> get props => [userId];
}
