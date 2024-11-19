import 'package:equatable/equatable.dart';

abstract class SplashscreenState extends Equatable {
  const SplashscreenState();

  @override
  List<Object> get props => [];
}
final class SplashscreenInitial extends SplashscreenState {}

 class SplashLoginCheckingState extends SplashscreenState{}
class SplashLoginCheckingErrorState extends SplashscreenState{}
class SplashEmailVerificationCheckState extends SplashscreenState{}
class SplashSendEmailVerificationState extends SplashscreenState{}
class SplashLoginCheckingSuccessState extends SplashscreenState{}

class SplashNavigatetoLoginState extends SplashscreenState{}
class SplashNavigateToHomeState extends SplashscreenState{}