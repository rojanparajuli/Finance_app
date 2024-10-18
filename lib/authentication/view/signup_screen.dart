import 'package:finance/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:finance/authentication/bloc/sign_up/sign_up_event.dart';
import 'package:finance/authentication/bloc/sign_up/sign_up_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF4F4F4),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign up successful!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context); // Pop the current page for manual sign-up
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          } else if (state is GoogleSignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Google Sign up successful!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is GoogleSignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Google Sign up failed: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            if (state is SignUpLoading) {
              return Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset('assets/animation.json'),
                ),
              );
            }

            bool termsAccepted = false;
            if (state is SignUpFormUpdated) {
              termsAccepted = state.termsAccepted;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
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
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      obscureText: true,
                      style: GoogleFonts.lora(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GFTextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                      obscureText: true,
                      style: GoogleFonts.lora(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GFCheckboxListTile(
                      title: Text(
                        "I agree to the Terms and Conditions",
                        style: GoogleFonts.lora(fontSize: 13),
                      ),
                      size: 25,
                      value: termsAccepted,
                      onChanged: (value) {
                        context
                            .read<SignUpBloc>()
                            .add(ToggleTermsAccepted(value));
                      },
                      activeBgColor: Appcolor.primary,
                      type: GFCheckboxType.circle,
                    ),
                    const SizedBox(height: 10),
                    GFButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final confirmPassword = _confirmPasswordController.text;
                        final fullName = _fullNameController.text;

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords do not match')),
                          );
                          return;
                        }

                        if (!termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('You must accept the terms')),
                          );
                          return;
                        }

                        context.read<SignUpBloc>().add(
                              SignUpSubmitted(email, password, fullName),
                            );
                      },
                      color: Appcolor.primary,
                      text: 'Sign Up',
                      textStyle: GoogleFonts.lora(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      fullWidthButton: true,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<SignUpBloc>()
                              .add(GoogleSignUpSubmitted());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/google_logo.png',
                                height: 24,
                              ),
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
                                          color:
                                              Color.fromARGB(255, 205, 185, 3),
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
