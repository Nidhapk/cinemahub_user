import 'package:equatable/equatable.dart';

abstract class ShowFilterState extends Equatable {
  const ShowFilterState();
  @override
  List<Object> get props => [];
}

class ShowFilterInitialState extends ShowFilterState {}

class RangefilterSelectedState extends ShowFilterState {
  final List<String> selectedPriceRanges;
  final List<String> selectedLanguages;
  const RangefilterSelectedState(
      {required this.selectedPriceRanges, required this.selectedLanguages});
  @override
  List<Object> get props => [selectedPriceRanges, selectedLanguages];
}

class LanguageFilterSelectedState extends ShowFilterState {
  final List<String> selectedLanguages;
  const LanguageFilterSelectedState({required this.selectedLanguages});
  @override
  List<Object> get props => [selectedLanguages];
}

class ShowFilterAppliedState extends ShowFilterState {
  final List<String> languages;
  final List<String> prices;
  const ShowFilterAppliedState({required this.languages, required this.prices});
 @override
  List<Object> get props => [languages,prices];
}
