import 'package:counter/feature/auth/logic/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_input.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthRegisterLoading) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()));
            }

            if (state is AuthRegisterSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Success Registeration"),
              ));
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }

            if (state is AuthRegisterFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Text(
                    "Register new  \naccount.",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your Username',
                    labelText: 'Username',
                    controller: userNameController,
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your Password',
                    labelText: 'Password',
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your email',
                    labelText: 'email',
                    controller: emailController,
                  ),
                  SizedBox(height: 24),
                  CustomTextInput(
                    hintText: 'Enter Your phone',
                    labelText: 'phone',
                    controller: phoneController,
                  ),
                  SizedBox(height: 24),
                  CustomButton(
                      label: 'Register',
                      onPressed: () {
                        context.read<AuthCubit>().register(
                            userNameController.text,
                            passwordController.text,
                            emailController.text,
                            phoneController.text);
                      }),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
