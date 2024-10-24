import 'package:finance/authentication/bloc/change_password/change_password_bloc.dart';
import 'package:finance/authentication/bloc/change_password/change_password_event.dart';
import 'package:finance/authentication/bloc/change_password/change_password_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final ValueNotifier<bool> _isOldPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isNewPasswordVisible = ValueNotifier(false);

  ChangePasswordPage({super.key});

  bool _validatePassword(String password) {
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasSpecialCharacter = password.contains(RegExp(r'[!@#\$&*~]'));
    final hasMinLength = password.length >= 6;
    return hasUpperCase && hasSpecialCharacter && hasMinLength;
  }

  void _showSnackbar(BuildContext context, String message,
      {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: GoogleFonts.lora(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: GoogleFonts.lora(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Appcolor.primary,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Change your password securely. Use at least 1 uppercase letter, 1 special character, and a minimum of 6 characters.",
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 220, 111, 111),
              ),
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: _isOldPasswordVisible,
              builder: (context, isVisible, child) {
                return TextField(
                  controller: _oldPasswordController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: "Old Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _isOldPasswordVisible.value = !isVisible;
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: _isNewPasswordVisible,
              builder: (context, isVisible, child) {
                return TextField(
                  controller: _newPasswordController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        _isNewPasswordVisible.value = !isVisible;
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            BlocListener<PasswordBloc, PasswordState>(
              listener: (context, state) {
                if (state is PasswordLoading) {
                } else if (state is PasswordChanged) {
                  _showSnackbar(context, "Password changed successfully!",
                      backgroundColor: Colors.green);

                  print('###########################');

                  Navigator.pop(context);
                } else if (state is PasswordError) {
                  _showSnackbar(context, state.message);
                  print('...........................');
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final oldPassword = _oldPasswordController.text.trim();
                    final newPassword = _newPasswordController.text.trim();

                    if (oldPassword.isEmpty) {
                      _showSnackbar(context, "Old password cannot be empty.");
                      return;
                    }

                    if (_validatePassword(newPassword)) {
                      context
                          .read<PasswordBloc>()
                          .add(ChangePasswordEvent(oldPassword, newPassword));
                    } else {
                      _showSnackbar(context,
                          "Password must be at least 6 characters long, contain 1 uppercase letter, and 1 special character.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Appcolor.primary,
                    shadowColor: Colors.black.withOpacity(0.2),
                    elevation: 5,
                  ),
                  child: Text(
                    "Change Password",
                    style: GoogleFonts.lora(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
