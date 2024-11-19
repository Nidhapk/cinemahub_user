import 'package:flutter/material.dart';
import 'package:userside/data/services/userauth_repository.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class CustomGoogleButton extends StatelessWidget {
  const CustomGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await Repository().signInWithGoogle().then(
              (value) => Navigator.of(context)
                  .pushNamedAndRemoveUntil('/splash', (context) => false),
            );
      },
      style: ElevatedButton.styleFrom(
          elevation: 1, foregroundColor: Colors.black, backgroundColor: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/search.png',
            height: 25,
            width: 25,
          ),
          const Text('Sign in with Google',),
        ],
      ),
    );
  }
}
