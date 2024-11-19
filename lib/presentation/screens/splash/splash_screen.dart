import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_event.dart';

import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_state.dart';
import 'package:userside/presentation/screens/user_auth/verify_screen.dart';
import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_bloc.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashscreenBloc>().add(CheckLoginEvent());
    return BlocListener<SplashscreenBloc, SplashscreenState>(
      listener: (context, state) {
        print('state   issssssssssssssssss $state');
        if (state is SplashNavigateToHomeState) {
          Navigator.of(context).pushReplacementNamed('/main');
        } else if (state is SplashNavigatetoLoginState) {
          Navigator.of(context).pushReplacementNamed('/signIn');
        } else if (state is SplashEmailVerificationCheckState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VerifiyScreen(
                user: FirebaseAuth.instance.currentUser,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<SplashscreenBloc, SplashscreenState>(
          builder: (context, state) {
            if (state is SplashLoginCheckingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SplashLoginCheckingErrorState) {
              return const Center(
                  child: Text('Error occurred. Please try again.'));
            } else {
              // If not in a state that should be handled by BlocListener, show a loading or static message
              return const Center(child: Text('Initializing...'));
            }
          },
        ),
      ),
    );
  }
}
