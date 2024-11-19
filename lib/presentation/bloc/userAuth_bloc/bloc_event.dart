import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {

  final String email;
  final String password;
  final BuildContext context;

  const SignInRequested(
  
    this.email,
    this.password,this.context
  );

  @override
  List<Object> get props => [email, password];
}
