import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/home/home_bloc.dart';
import 'package:finance/bloc/home/home_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.primary,
        title: Text(
          'Dashboard',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Drawer(),
      body: BlocBuilder<QuoteBloc, QuoteState>(
  builder: (context, state) {
    if (state is QuoteInitial) {
      print("State: QuoteInitial");
      return const Center(child: LoadingScreen());
    } else if (state is QuoteLoaded) {
      print("State: QuoteLoaded - Quote: ${state.quote}");
      return Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.quote,
                style: GoogleFonts.lora(fontSize: 24, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopScreen()),
              );
            },
            child: Text(
              'Add Shop',
              style: GoogleFonts.lora(),
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Text('Error loading quote', style: GoogleFonts.lora()),
      );
    }
  },
),

    );
  }
}
