import 'package:finance/bloc/about/about_us_bloc.dart';
import 'package:finance/bloc/about/about_us_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Appcolor.primary,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AboutUsLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Helping You Manage Your Finances',
                      style: GoogleFonts.lora(
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.content,
                      style: GoogleFonts.lora(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        height: 1.5, 
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.security, size: 40, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          'Secure and Safe Data',
                          style: GoogleFonts.lora(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            fontWeight: FontWeight.w600,
                            color: Appcolor.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We use state-of-the-art encryption and authentication techniques to ensure that your financial data is safe and only accessible by you.',
                      style: GoogleFonts.lora(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet,
                            size: 40, color: Colors.blue),
                        const SizedBox(width: 10),
                        Text(
                          'Track Your Debts & Credits',
                          style: GoogleFonts.lora(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            fontWeight: FontWeight.w600,
                            color: Appcolor.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Keep an accurate record of what you owe and who owes you, so you can always stay on top of your financial commitments.',
                      style: GoogleFonts.lora(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
