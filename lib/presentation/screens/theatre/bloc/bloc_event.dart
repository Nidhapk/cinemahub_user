import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:userside/data/model/movie/theatre_model.dart';

abstract class TheatreEvent extends Equatable {
  const TheatreEvent();
  @override
  List<Object> get props => [];
}

class FetchAllTheatresTheatreEvent extends TheatreEvent {
  const FetchAllTheatresTheatreEvent();
  @override
  List<Object> get props => [];
}

class SelectTheatreEvent extends TheatreEvent {
  final TheatreModel selectedTheatre;
  final LatLng userLocation;

  const SelectTheatreEvent(this.selectedTheatre,this.userLocation);
  @override
  List<Object> get props => [selectedTheatre,userLocation];
}

class SearchTheatresEvent extends TheatreEvent {
  final String query;

  const SearchTheatresEvent(this.query);
  @override
  List<Object> get props => [query];
}
