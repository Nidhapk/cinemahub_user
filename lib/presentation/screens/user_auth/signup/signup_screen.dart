// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/methods/validation_methods.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/themes/app_textstyles.dart';
import 'package:userside/presentation/widget/back_arrow.dart';
import 'package:userside/presentation/widget/custom_snackbar.dart';
import 'package:userside/presentation/widget/custome_textform.dart';
import 'package:userside/presentation/widget/customrow_one.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  static final GlobalKey<FormState> formKeyy = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                      text: 'User registered successfully',
                      icon: Icons.check_circle_outline,
                      iconColor: green,
                      borderColor: green,
                      backgroundColor: paleGreen),
                );
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/splash', (context) => false);
              } else if (state is SignUpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                      text: state.error,
                      icon: Icons.error_outline,
                      iconColor: red,
                      borderColor: red,
                      backgroundColor: paleRed),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: formKeyy,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackArrow(),
                     Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Sign in',
                        style: AppTextstyles.headlineLarge,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 25),
                      child: Text(
                        'Let\'s create your account',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CustomTextForm(
                      obscureText: false,
                      controller: emailController,
                      validator: (value) =>emailValidator(value),
                      hintText: 'Your email',
                      labelText: 'email',
                      suffixIcon:  Icon(
                        Icons.email_outlined,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    CustomTextForm(
                      obscureText: true,
                      controller: passwordController,
                      validator: (value) => passwordValidator(value),
                      hintText: 'Your password',
                      labelText: 'password',
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    CustomTextForm(
                      obscureText: true,
                      controller: confirmPassController,
                      validator: (value) => confirmPassValidator(
                        value,
                        passwordController.text.trim(),
                      ),
                      hintText: 'Confirm password',
                      labelText: 'Confirm password',
                      suffixIcon:  Icon(
                        Icons.remove_red_eye_outlined,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKeyy.currentState!.validate()) {
                            context.read<SignUpBloc>().add(
                                  SignUpRequestedEvent(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        child: const Text('Sign Up '),
                      ),
                    ),
                    RowOne(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/signIn');
                        },
                        text: 'Sign In',
                        textTwo: 'Already have an account ?')
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
