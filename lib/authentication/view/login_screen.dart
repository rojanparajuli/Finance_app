import 'package:finance/authentication/bloc/login_bloc.dart';
import 'package:finance/authentication/bloc/login_state.dart';
import 'package:finance/authentication/view/forget_password_view.dart';
import 'package:finance/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
          if (state is LoginLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is LoginSuccess || state is LoginFailure) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/3ba8f-mega.png',
                    height: 200,
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildUsernameField(),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 16),
                        _buildRememberMeCheckbox(),
                        const SizedBox(height: 20),
                        _buildLoginButton(),
                        const SizedBox(height: 20),
                        _buildLoadingAnimation(),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: const Text(
                            'Forgot Pasword?',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
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
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Row _buildRememberMeCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.all(Colors.grey),
          side: const BorderSide(color: Colors.grey, width: 2),
        ),
        const Text(
          'Remember Me',
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
          ),
        ),
      ],
    );
  }

  SizedBox _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
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
          onPressed: _isLoading
              ? null
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
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
