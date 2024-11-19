import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: ListView(
          children: [
            const Text(
              'CinemaHub',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const Text(
              'Verson 1.0',
              style: TextStyle(
                  color: Color.fromARGB(255, 149, 148, 148),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: width * 0.05,
            ),
            const Text(
                'Welcome to CinemaHub, the ultimate platform for movie lovers to discover and enjoy cinema experiences like never before. Our app brings the magic of movies closer to you by connecting you with theaters, shows, and seats all in one convenient place. CinemaHub makes it easy to browse the latest releases, find showtimes, and secure your seats with just a few taps.At BookMySeat, we believe that a great movie experience begins with convenience. We partner with local theaters to provide up-to-date movie listings, personalized show recommendations, and a seamless booking process that takes the hassle out of ticket buying. Our mission is to enhance your movie-watching journey by offering a platform that values simplicity, speed, and choice.')
          ],
        ),
      ),
    );
  }
}
