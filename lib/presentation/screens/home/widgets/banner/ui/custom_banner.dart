import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_state.dart';

Widget customBanner(
    {required BuildContext context,
    required List<String> images,
    required PageController pageController,
    required int currentIndex}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  // final PageController _pageController = PageController();
  return BlocBuilder<BannerBloc, BannerState>(
    builder: (context, state) {
      if (state is BannerImageChangedState) {
        currentIndex = state.currentPage;
      }

      return SizedBox(
        height: height * 0.22,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Banner Images PageView
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                //decoration:
                //BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: height * 0.20,
                width: width * 0.93,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    context.read<BannerBloc>().add(
                          BannerImageChangedEvent(index: index),
                        );
                  },
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      //  height: height * 0.25,
                      // width: width * 0.93,
                      decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            images[index],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Page Indicator
            Positioned(
              left: width / 2 - 20,
              bottom: 0,
              child: SmoothPageIndicator(
                controller: pageController,
                count: images.length,
                effect: const WormEffect(
                  dotHeight: 5,
                  dotWidth: 5,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
