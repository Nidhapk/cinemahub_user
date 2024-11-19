import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/methods/validation_methods.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_bloc.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_event.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/themes/app_textstyles.dart';
import 'package:userside/presentation/widget/button_google.dart';
import 'package:userside/presentation/widget/custom_divider.dart';
import 'package:userside/presentation/widget/custom_snackbar.dart';
import 'package:userside/presentation/widget/custome_textform.dart';
import 'package:userside/presentation/widget/customrow_one.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                        text: 'Succesfully logged in',
                        icon: Icons.check_circle,
                        iconColor: green,
                        borderColor: green,
                        backgroundColor: paleGreen),
                  );
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/splash', (context) => false);
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                        text: state.message,
                        icon: Icons.check_circle,
                        iconColor: red,
                        borderColor: red,
                        backgroundColor: paleRed),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign in',
                    style: AppTextstyles.headlineLarge,
                  ),
                  const SizedBox(height: 50),
                  CustomTextForm(
                    obscureText: false,
                    hintText: 'Enter your email',
                    labelText: 'email',
                    controller: emailController,
                    suffixIcon:  Icon(
                      Icons.email_outlined,
                      color: primaryColor,
                      size: 20,
                    ),
                    validator: (value) => emailValidator(value),
                  ),
                  ValueListenableBuilder(
                    valueListenable: obscureTextNotifier,
                    builder: (context, notifier, _) {
                      return CustomTextForm(
                        obscureText: notifier,
                        controller: passwordController,
                        hintText: 'Enter your password ?',
                        labelText: 'password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscureTextNotifier.value =
                                !obscureTextNotifier.value;
                          },
                          icon: Icon(
                            notifier
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                            color: primaryColor,
                          ),
                        ),
                        validator: (value) => passwordValidator(value),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.6),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgetPass');
                      },
                      child:  Text(
                        'Forget password ? ',
                        style: AppTextstyles.forgetPassStyle,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInRequested(emailController.text.trim(),
                                  passwordController.text.trim(), context),
                            );
                      }
                    },
                    child: const Text('Sign in'),
                  ),
                  const CustomDivider(),
                  const CustomGoogleButton(),
                  const SizedBox(height: 20),
                  RowOne(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signUp', (context) => false);
                    },
                    text: 'Sign Up',
                    textTwo: 'Don\'t have an account ?',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
