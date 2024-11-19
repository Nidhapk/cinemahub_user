import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userside/presentation/screens/home/home_screen.dart';
import 'package:userside/presentation/screens/movies/ui/movies_screen.dart';
import 'package:userside/presentation/screens/profile/profile_screen.dart';
import 'package:userside/presentation/screens/theatre/theatre_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: currentIndex == 3
          ? const Color.fromARGB(255, 236, 236, 238)
          : Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(width * 0.03),
        height: width * 0.155,
        decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: primaryColor.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10))
            ],
            borderRadius: BorderRadius.circular(50)),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: width * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex ? width * .32 : width * 0.18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? width * 0.12 : 0,
                    width: index == currentIndex ? width * 0.32 : 0,
                    decoration: BoxDecoration(
                        color: index == currentIndex
                            ? primaryColor.withOpacity(0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex ? width * 0.31 : width * 0.18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex ? width * 0.09 : 0,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex ? listTitles[index] : '',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == currentIndex ? width * 0.06 : 20,
                          ),
                          Icon(
                            listIcons[index],
                            size: width * 0.065,
                            color: index == currentIndex
                                ? primaryColor
                                : Colors.black26,
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> pages = [
    const HomeScreenn(),
    const MovieScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];
  List<String> listTitles = ['Home', 'Movies', 'Map', 'Profile'];
  List<IconData> listIcons = [
    Icons.home_rounded,
    Icons.movie_filter_sharp,
    Icons.map,
    Icons.person_4_rounded
  ];
}
