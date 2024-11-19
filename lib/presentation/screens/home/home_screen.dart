import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/banner/ui/custom_banner.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/coming_soon_widget.dart';
import 'package:userside/presentation/screens/home/widgets/home_appbar.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/now_showing_movies.dart';
import 'package:userside/presentation/screens/home/widgets/today_showing/today_showing.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class HomeScreenn extends StatefulWidget {
  const HomeScreenn({super.key});

  @override
  State<HomeScreenn> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenn> {
  final List<String> images = [
    'assets/Design.png',
    'assets/Design.png',
    'assets/Design.png',
  ];

  int currentIndex = 0;
  final PageController _pageController = PageController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startImageSlider();
  }

  void startImageSlider() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        currentIndex = (currentIndex + 1) % images.length;

        context.read<BannerBloc>().add(
              BannerImageChangedEvent(index: currentIndex),
            );

        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<NowShowingMovieBloc>().add(FetchNowShowingMovieEvent());
    context.read<ComingSoonMovieBloc>().add(FetchcomingSoonMovieEvent());
    context.read<MovieBloc>().add(FetchTodaysMoviesEvent());
    return Scaffold(
      backgroundColor: white,
      appBar: homeAppbar(context),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
       const   SizedBox(
            height: 20,
          ),
          customBanner(
              context: context,
              images: images,
              pageController: _pageController,
              currentIndex: currentIndex),
          todayShowingMoviesContainer(context),
        
          const NowShowingMovies(
            title: 'Now Showing',
          ),
          const ComingSoonMoviesShows(
            title: 'Coming Soon',
          ),
        ],
      ),
    );
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
