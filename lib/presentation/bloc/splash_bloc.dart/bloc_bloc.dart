import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_event.dart';
import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_state.dart';
import 'package:userside/data/services/userauth_repository.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<CheckLoginEvent>(_onCheckLogin);
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<SplashscreenState> emit) async {
    try {
      emit(
        SplashLoginCheckingState(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        await user.reload();
        user = FirebaseAuth.instance.currentUser;
        bool signedInWithGoogle = user!.providerData.any(
          (userInfo) => userInfo.providerId == 'google.com',
        );
        if (signedInWithGoogle == true) {
          emit(
            SplashNavigateToHomeState(),
          );
        } else if (user.emailVerified) {
          emit(
            SplashNavigateToHomeState(),
          );
        } else {
          Repository().sendVerificationLink();
          emit(
            SplashEmailVerificationCheckState(),
          );
        }
      } else {
        emit(
          SplashNavigatetoLoginState(),
        );
      }
    } catch (error) {
      emit(
        SplashLoginCheckingErrorState(),
      );
    }
  }
}
