import 'package:equatable/equatable.dart';

abstract class ShowFilterEvent extends Equatable {
  const ShowFilterEvent();
  @override
  List<Object> get props => [];
}

class PriceRangeAppliedEvent extends ShowFilterEvent {
  final String price;
  const PriceRangeAppliedEvent(this.price);
  @override
  List<Object> get props => [price];
}

class LanguageAppliedEvent extends ShowFilterEvent {
  final String language;
  const LanguageAppliedEvent(this.language);
  @override
  List<Object> get props => [language];
}

class ShowFiltersAppliedEvent extends ShowFilterEvent {
  final List<String> price;
  final List<String> language;
  const ShowFiltersAppliedEvent({required this.price, required this.language});
  @override
  List<Object> get props => [price,language];
}

class ResetShowFiltersEvent extends ShowFilterEvent {
 const ResetShowFiltersEvent();
 @override
  List<Object> get props => [];
 
}
