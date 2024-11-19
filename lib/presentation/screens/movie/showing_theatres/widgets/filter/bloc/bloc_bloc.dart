import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_state.dart';

class ShowFilterBloc extends Bloc<ShowFilterEvent, ShowFilterState> {
  List<String> selectedPriceRanges = [];
  List<String> selectedLanguages = [];
  ShowFilterBloc() : super(ShowFilterInitialState()) {
    on<PriceRangeAppliedEvent>(rangeFilterSelected);
    on<LanguageAppliedEvent>(languageFilterSelected);
    on<ResetShowFiltersEvent>(filtersReseted);
    on<ShowFiltersAppliedEvent>(filtersApplied);
  }

  Future<void> rangeFilterSelected(
      PriceRangeAppliedEvent event, Emitter<ShowFilterState> emit) async {
    if (selectedPriceRanges.contains(event.price)) {
      selectedPriceRanges.remove(event.price);
      log('listfrom  ${List.from(selectedPriceRanges)}  ');
      log('$selectedLanguages');
    } else {
      selectedPriceRanges.add(event.price);
      log('listfrom  ${List.from(selectedPriceRanges)}  ');
      log('$selectedLanguages');
    }
    log('emitig state');
    emit(
      RangefilterSelectedState(
        selectedLanguages: List.from(selectedLanguages),
        selectedPriceRanges: List.from(selectedPriceRanges),
      ),
    );
  }

  Future<void> languageFilterSelected(
      LanguageAppliedEvent event, Emitter<ShowFilterState> emit) async {
    log('working');
    if (selectedLanguages.contains(event.language)) {
      selectedLanguages.remove(event.language);
    } else {
      selectedLanguages.add(event.language);
    }
    log('language state');

    emit(
      RangefilterSelectedState(
        selectedPriceRanges: List.from(selectedPriceRanges),
        selectedLanguages: List.from(selectedLanguages),
      ),
    );
  }

  Future<void> filtersReseted(
      ResetShowFiltersEvent event, Emitter<ShowFilterState> emit) async {
    selectedLanguages.clear();
    selectedPriceRanges.clear();
    emit(
      RangefilterSelectedState(
        selectedPriceRanges: List.from(selectedPriceRanges),
        selectedLanguages: List.from(selectedLanguages),
      ),
    );
  }

  Future<void> filtersApplied(
      ShowFiltersAppliedEvent event, Emitter<ShowFilterState> emit) async {
    emit(
      ShowFilterAppliedState(
        languages: List.from(selectedLanguages),
        prices: List.from(selectedPriceRanges),
      ),
    );
  }
}
