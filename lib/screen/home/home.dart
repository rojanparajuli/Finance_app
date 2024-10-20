import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/home/home_bloc.dart';
import 'package:finance/bloc/home/home_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/shop/shop_screen.dart';
import 'package:finance/widget/drawer_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      appBar: AppBar(
        backgroundColor: Appcolor.primary,
        title: Text(
          'Dashboard',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 22, // Larger title font for better readability
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                // Add a Snackbar for notification click
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'No new notifications!',
                      style: GoogleFonts.lora(),
                    ),
                    backgroundColor: Colors.black87,
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                size: 30,
              ),
            ),
          )
        ],
      ),
      drawer: const Drawer(
        child: DrawerItem(),
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, state) {
          if (state is QuoteInitial) {
            print("State: QuoteInitial");
            return const Center(child: LoadingScreen());
          } else if (state is QuoteLoaded) {
            print("State: QuoteLoaded - Quote: ${state.quote}");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add some spacing and formatting to the quote section
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Text(
                      state.quote,
                      style: GoogleFonts.lora(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 20.0),
                  // Add a call-to-action button with better styling
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShopScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag),
                        Text(
                           'Shops',
                          style: GoogleFonts.lora(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Error loading quote',
                style: GoogleFonts.lora(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
