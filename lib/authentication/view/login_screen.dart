import 'package:finance/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:finance/authentication/bloc/sign_up/sign_up_event.dart';
import 'package:finance/authentication/view/forget_password_view.dart';
import 'package:finance/authentication/view/signup_screen.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/authentication/bloc/login/login_bloc.dart';
import 'package:finance/authentication/bloc/login/login_event.dart';
import 'package:finance/authentication/bloc/login/login_state.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/text_field/gf_text_field.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(GetRememberMe());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful!')),
            );
            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Lottie.asset('assets/animation.json')));
            }
            if (state is GetSaveRememberMeSuccess) {
              _emailController.text = state.email;
              _passwordController.text = state.password;
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset(
                      'assets/Firebase.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  GFTextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.lora(
                          fontSize: 18, fontWeight: FontWeight.w600),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: GoogleFonts.lora(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          GFTextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.lora(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                              ),
                            ),
                            obscureText: state is! PasswordVisible,
                            style: GoogleFonts.lora(fontSize: 16),
                          ),
                          Positioned(
                            right: 10,
                            top: 15,
                            child: GestureDetector(
                              onTap: () {
                                if (state is PasswordVisible) {
                                  context
                                      .read<LoginBloc>()
                                      .add(PasswordVisibilityChanged(false));
                                } else {
                                  context
                                      .read<LoginBloc>()
                                      .add(PasswordVisibilityChanged(true));
                                }
                              },
                              child: Icon(
                                state is PasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  GFButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final isRemember = state is RememberMeChecked;
                      context
                          .read<LoginBloc>()
                          .add(LoginSubmitted(email, password, isRemember));
                    },
                    color: Appcolor.primary,
                    text: 'Login',
                    textStyle: GoogleFonts.lora(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    fullWidthButton: true,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value:
                                    state is RememberMeChecked ? true : false,
                                onChanged: (bool? value) {
                                  if (state is RememberMeChecked) {
                                    context.read<LoginBloc>().add(
                                        RememberMeChanged(isRemember: false));
                                    context.read<LoginBloc>().add(
                                        RemoveSavedRememberMe(
                                            message: 'Removed'));
                                  } else {
                                    context.read<LoginBloc>().add(
                                        RememberMeChanged(isRemember: true));
                                    context
                                        .read<LoginBloc>()
                                        .add(SaveRememberMe(
                                          message: 'Saved',
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ));
                                  }
                                },
                              ),
                              Text(
                                'Remember Me',
                                style: GoogleFonts.lora(fontSize: 16),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.lora(
                                  fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(color: Colors.grey, height: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or login with',
                          style: GoogleFonts.lora(
                              color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: Colors.grey, height: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.read<SignUpBloc>().add(GoogleSignUpSubmitted());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/google_logo.png', height: 24),
                          const SizedBox(width: 10),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Continue with ',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'G',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'o',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'o',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 205, 185, 3),
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'g',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'l',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: 'e',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.lora(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: GoogleFonts.lora(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "Sign-up",
                            style: GoogleFonts.lora(
                              color: Appcolor.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
