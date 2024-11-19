
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/language_filters.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/filter_text_builder.dart';

void filterModelBottomSheet({
  required BuildContext context,
  required void Function()? resetFilterOnPressed,
  required void Function()? applyFilterOnPressed,
}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  List<String> priceRanges = ['0-150', '151-300'];
  List<String> languages = ['English', 'Hindi', 'Malayalam'];
  List<String> selectedLanguages = [];
  List<String> selectedPrices = [];
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        width: width,
        height: height * 0.43,
        child: BlocBuilder<ShowFilterBloc, ShowFilterState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: height * 0.01,
                  ),
                ),
                Center(
                  child: Container(
                    width: width * 0.2,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Center(
                  child: Text(
                    'Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  color: primaryColor.withOpacity(
                    0.1,
                  ),
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        top: height * 0.01,
                        bottom: height * 0.01),
                    child: const Text(
                      'Price Range',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                BlocBuilder<ShowFilterBloc, ShowFilterState>(
                  builder: (context, state) {
                    if (state is RangefilterSelectedState) {
                      selectedPrices = state.selectedPriceRanges;
                      return FilterTextBuilder(
                        selectedValues: state.selectedPriceRanges,
                        values: priceRanges,
                      );
                    } else {
                      return FilterTextBuilder(
                        selectedValues: selectedPrices,
                        values: priceRanges,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  color: primaryColor.withOpacity(
                    0.1,
                  ),
                  width: width,
                  //   height: height * 0.05,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                      top: height * 0.01,
                      bottom: height * 0.01,
                    ),
                    child: const Text(
                      'Languages',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                BlocBuilder<ShowFilterBloc, ShowFilterState>(
                  builder: (context, state) {
                    if (state is RangefilterSelectedState) {
                      selectedLanguages = state.selectedLanguages;
                      return LanguageFiltersBuilder(
                          values: languages,
                          selectedValues: state.selectedLanguages);
                    } else {
                      return LanguageFiltersBuilder(
                          values: languages, selectedValues: selectedLanguages);
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Divider(
                  height: 0,
                  thickness: 0.3,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.45,
                      height: height * 0.043,
                      child: ElevatedButton(
                        onPressed: resetFilterOnPressed,
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(
                                5,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            backgroundColor: white,
                            foregroundColor: primaryColor),
                        child: const Text(
                          'Reset Filters',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.45,
                      height: height * 0.043,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ShowFilterBloc>().add(
                              ShowFiltersAppliedEvent(
                                  price: selectedPrices,
                                  language: selectedLanguages));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(
                                5,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            backgroundColor: primaryColor,
                            foregroundColor: white),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      );
    },
  );
}
