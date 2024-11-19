import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/userauth_repository.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequestedEvent>(signUpRequested);
  }

  Future<void> signUpRequested(
      SignUpRequestedEvent event, Emitter<SignUpState> emit) async {
    emit(
      SignUpInProgress(),
    );
    try {
      await Repository().signUp(event.email, event.password);
      emit(
        SignUpSuccess(),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          emit(
            SignUpFailure(
                'The email address is already in use by another account.'),
          );
          break;
        case 'invalid-email':
          emit(
            SignUpFailure('The email address is not valid.'),
          );
          break;
        default:
          emit(
            SignUpFailure('An unknown error occurred: ${e.message}'),
          );
          break;
      }
    } on SocketException {
      emit(
        SignUpFailure(
            'No internet connection. Please check your network settings.'),
      );
    } on TimeoutException {
      emit(
        SignUpFailure('The request timed out. Please try again later.'),
      );
    } catch (e) {
      emit(
        SignUpFailure('An unexpected error occurred: $e'),
      );
    }
  }
}
