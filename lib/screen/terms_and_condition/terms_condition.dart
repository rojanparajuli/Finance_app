import 'package:finance/authentication/view/login_screen.dart';
import 'package:finance/authentication/view/signup_screen.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/bloc/terms_condition/terms_bloc.dart';
import 'package:finance/bloc/terms_condition/terms_state.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TermsBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms and Conditions",
          style: GoogleFonts.lora(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Appcolor.primary,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
      ),
      body: BlocBuilder<TermsBloc, TermsState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.openSans(
                          color: Colors.grey[800], fontSize: 16.0),
                      children: [
                        const TextSpan(
                          text: "Welcome to the Finance Tracker App!\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Appcolor.primary),
                        ),
                        TextSpan(
                          text:
                              "Please review the following terms and conditions carefully before using the app.\n\n",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        const TextSpan(
                          text: "1. General Terms\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Appcolor.secondary),
                        ),
                        const TextSpan(
                          text:
                              "These terms govern your use of the Finance Tracker App. By accessing the app, you agree to be bound by these terms.\n\n",
                        ),
                        const TextSpan(
                          text: "2. Data Usage for Research Purposes\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                        const TextSpan(
                          text:
                              "We may use your financial tracking data in an anonymized and aggregated format for research and analysis purposes. "
                              "Your data will not be shared with third parties without your consent, except as necessary to conduct analytics "
                              "to improve app functionality and performance.\n\n",
                        ),
                        const TextSpan(
                          text: "3. User Obligations\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Appcolor.secondary),
                        ),
                        const TextSpan(
                          text:
                              "You agree to use the Finance Tracker app responsibly and only for lawful purposes.\n\n",
                        ),
                        const TextSpan(
                          text: "4. Security of Your Data\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.redAccent),
                        ),
                        const TextSpan(
                          text:
                              "While we take reasonable measures to protect your data, we cannot guarantee complete security. Please exercise caution when sharing sensitive information.\n\n",
                        ),
                        const TextSpan(
                          text: "5. Modifications\n\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Appcolor.secondary),
                        ),
                        const TextSpan(
                          text:
                              "We reserve the right to modify these terms at any time. Continued use of the app after changes indicates acceptance of the modified terms.\n\n",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thank you for you can continue using application'),
                             duration: Duration(seconds: 5),
                          ),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        "Accept",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Thank you for installing our application'),
                             duration: Duration(seconds: 5),
                          ),
                        );
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        "Decline",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
