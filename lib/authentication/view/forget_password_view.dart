import 'package:finance/authentication/bloc/forget_password/forget_password_bloc.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_event.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/text_field/gf_text_field.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: Text('Forgot Password', style: GoogleFonts.lora()),
        centerTitle: true,
        backgroundColor: const Color(0xFFF4F4F4),
        automaticallyImplyLeading: false,
      ),
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
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GFButton(
                    onPressed: () {
                      final email = _emailController.text.trim();
                      if (email.isNotEmpty) {
                        BlocProvider.of<ForgotPasswordBloc>(context)
                            .add(ForgotPasswordEmailSubmitted(email));
                      }
                    },
                    color: Appcolor.primary,
                    text: 'Send Reset Link',
                    textStyle: GoogleFonts.lora(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    fullWidthButton: true,
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
