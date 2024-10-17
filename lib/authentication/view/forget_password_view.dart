import 'package:finance/authentication/bloc/login_bloc.dart';
import 'package:finance/authentication/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset(
              'assets/3ba8f-mega.png',
              height: 200,
            ),
            const SizedBox(height: 20),
            _buildUsernameField(),
            const SizedBox(height: 20),
            _buildLoginButton(context),
            const SizedBox(height: 20),
            _buildLoadingAnimation(),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  TextFormField _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Email Address';
        }
        return null;
      },
    );
  }

  SizedBox _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          bool isLoading = state is LoginLoading;
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request sent successfully'),
                        ),
                      );
                    },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Send Reset Email',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingAnimation() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return Lottie.asset(
            'assets/animation.json',
            height: 100,
          );
        }
        return Container();
      },
    );
  }
}
