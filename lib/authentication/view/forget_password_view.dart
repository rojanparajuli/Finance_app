import 'package:finance/authentication/bloc/forget_password/forget_password_bloc.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_event.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password', style: GoogleFonts.lora())),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Password reset email sent!'),
            ));
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter your email to receive a password reset link:',
                style: GoogleFonts.lora(fontSize: 18),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                style: GoogleFonts.lora(),
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      if (email.isNotEmpty) {
                        BlocProvider.of<ForgotPasswordBloc>(context)
                            .add(ForgotPasswordEmailSubmitted(email));
                      }
                    },
                    child: Text(
                      'Send Reset Link',
                      style: GoogleFonts.lora(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
