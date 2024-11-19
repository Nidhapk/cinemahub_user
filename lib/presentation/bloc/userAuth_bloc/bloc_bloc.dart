import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/userauth_repository.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_event.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(signinRequest);
  }
}

Future<void> signinRequest(
    SignInRequested event, Emitter<AuthState> emit) async {
  emit(AuthButtonPreed());

  try {
    await Repository()
        .sigin( event.email, event.password, event.context);
    emit(AuthSuccess());
  } on FirebaseAuthException catch (e) {
   // print(e);
    if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
      emit(
        const AuthFailure(message: 'Invalid email or password'),
      );
    } else if (e.code == 'network-request-failed') {
      emit(
        const AuthFailure(message: 'Network error : Try again later'),
      );
    } else {
      emit(
        const AuthFailure(message: 'An unexpected error occurred.'),
      );
    }
  } catch (e) {
    emit(
      AuthFailure(message: '$e'),
    );
  }


}

