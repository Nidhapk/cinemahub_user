import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();
  @override
  List<Object> get props => [];
}

class BannerImageChangedEvent extends BannerEvent {
  final int index;
  final bool isAutomatic; // Flag to indicate if this change is automatic

  const BannerImageChangedEvent({required this.index, this.isAutomatic = false});
}


class BannerNextPageEvent extends BannerEvent {
  const BannerNextPageEvent();
  @override
  List<Object> get props => [];
}
