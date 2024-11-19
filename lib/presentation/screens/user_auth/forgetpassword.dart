import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/bloc/foregetPassword/bloc_bloc.dart';
import 'package:userside/presentation/bloc/foregetPassword/bloc_event.dart';
import 'package:userside/presentation/bloc/foregetPassword/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/widget/custom_snackbar.dart';
import 'package:userside/presentation/widget/custome_textform.dart';
import 'package:userside/presentation/widget/sizedbox_one.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: BlocListener<ForgetPassBloc, ForgetPassState>(
        listener: (context, state) {
          if (state is ForgetPassEmailSendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: 'Verify email has been sent',
                  icon: Icons.check_circle_outlined,
                  iconColor: green,
                  borderColor:green,backgroundColor: paleGreen),
            );
            Navigator.of(context).pop();
          } else if (state is ForgetPassEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: state.error,
                  icon: Icons.error_outline_outlined,
                  iconColor:red,
                  borderColor: red,backgroundColor:paleRed ),
            );
          }
        },
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBoxOne(),
              const Text(
                'Enter email associated with your account and\n we \'ll send an email with to rset password',
                textAlign: TextAlign.center,
              ),
              const SizedBoxOne(),
              CustomTextForm(
                controller: emailController,
                hintText: 'Enter email',
                labelText: 'email',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'email cant\'t be empty';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ForgetPassBloc>().add(
                          SendResetPasswordLink(
                            email: emailController.text.trim(),
                          ),
                        );
                  }
                },
                child: const Text('Send'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
