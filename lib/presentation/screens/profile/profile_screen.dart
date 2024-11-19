import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userside/presentation/screens/profile/about_us/ui/about_us.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/ui/fav_theatres.dart';
import 'package:userside/presentation/screens/profile/location/widget/location.dart';
import 'package:userside/presentation/screens/profile/location/widget/location_toggle_bar.dart';
import 'package:userside/presentation/screens/profile/my_bookings/ui/my_bookings.dart';
import 'package:userside/presentation/screens/profile/privacy_policy/ui/privacy_policy.dart';
import 'package:userside/presentation/screens/user_auth/forgetpassword.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/profile_page/custom_container.dart';
import 'package:userside/presentation/widget/profile_page/item_tile.dart';
import 'package:userside/presentation/widget/sizedbox_one.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.5),
                radius: 30,
                backgroundImage:
                    FirebaseAuth.instance.currentUser?.photoURL == null ||
                            FirebaseAuth.instance.currentUser!.photoURL!.isEmpty
                        ? null
                        : NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                          ),
                child: FirebaseAuth.instance.currentUser?.photoURL == null ||
                        FirebaseAuth.instance.currentUser!.photoURL!.isEmpty
                    ? Text(
                        FirebaseAuth.instance.currentUser!.email!
                            .substring(
                                0,
                                FirebaseAuth.instance.currentUser!.email!
                                    .indexOf('@'))
                            .substring(0, 1)
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email ?? '',
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  )
                ],
              )
            ],
          ),
          const Divider(
            height: 0,
            thickness: 0.5,
            color: Color.fromARGB(255, 236, 236, 238),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBoxOne(),
                  customContainer(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      String title;
                      IconData icon;
                      void Function()? onTap;
                      switch (index) {
                        case 0:
                          title = 'Your Bookings';
                          icon = Icons.local_movies_outlined;
                          onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyBookings(),
                              ),
                            );
                          };
                          break;
                        default:
                          title = 'Favourite Cinemas';

                          onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FavTheatres(),
                              ),
                            );
                          };
                          icon = Icons.favorite_border;
                      }
                      return itemTile(title: title, onTap: onTap, icon: icon);
                    },
                  ),
                  const SizedBoxOne(),
                  customContainer(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      String title;
                      IconData icon;
                      void Function()? onTap;
                      switch (index) {
                        case 0:
                          title = 'About Us';
                          icon = Icons.info_outline;
                          onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const AboutUsScreen()));
                          break;

                        default:
                          title = 'Privacy Policy';
                          icon = Icons.privacy_tip_rounded;
                          onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy()));
                      }
                      return itemTile(icon: icon, title: title, onTap: onTap);
                    },
                  ),
                  const SizedBoxOne(),
                  customContainer(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      String title;
                      IconData icon;
                      void Function()? onTap;
                      switch (index) {
                        case 0:
                          title = 'Forget Password';
                          icon = Icons.lock;
                          onTap = () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPassScreen()));
                          break;
                        default:
                          icon = Icons.logout;
                          title = 'Logout';
                      }
                      return itemTile(title: title, onTap: onTap, icon: icon);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
