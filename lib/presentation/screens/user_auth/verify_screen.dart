import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userside/data/services/userauth_repository.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/sizedbox_one.dart';

class VerifiyScreen extends StatelessWidget {
  final User? user;
  const VerifiyScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/Mail Envelope With 1 Alert.jpg',
              height: 100,
            ),
          ),
          const Text(
            'Check your email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Text(
            'We have send an email to your account \nopen the email and click on the link to verify!',
            textAlign: TextAlign.center,
          ),
          const SizedBoxOne(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(maximumSize: const Size(290, 40)),
              onPressed: () {
                Repository().checkVerified(context, user!);
              },
              child: const Text(
                'Yes, I have verified',
              ))
        ],
      ),
    );
  }
}
