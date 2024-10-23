import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/home/home_bloc.dart';
import 'package:finance/bloc/home/home_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/shop/shop_screen.dart';
import 'package:finance/widget/drawer_items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Appcolor.primary,
        title: Text(
          'Dashboard',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 22,
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[100]!,
              Colors.grey[300]!,
            ],
          ),
        ),
        child: BlocBuilder<QuoteBloc, QuoteState>(
          builder: (context, state) {
            if (state is QuoteInitial) {
              return const Center(child: LoadingScreen());
            } else if (state is QuoteLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.grey[100]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 3.0,
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
                      const SizedBox(height: 30),
                      Divider(color: Colors.grey[400], thickness: 1),
                      const SizedBox(height: 30),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        children: [
                          GFButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopScreen(),
                                ),
                              );
                            },
                            text: "Shops",
                            icon: const Icon(Icons.shopping_bag,
                                color: Colors.white, size: 16),
                            color: Appcolor.primary,
                            shape: GFButtonShape.standard,
                            size: GFSize.SMALL,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            textStyle: GoogleFonts.lora(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GFButton(
                            onPressed: () {},
                            text: "Lending",
                            icon: const Icon(Icons.person,
                                color: Colors.white, size: 16),
                            color: Appcolor.primary,
                            shape: GFButtonShape.standard,
                            size: GFSize.SMALL,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            textStyle: GoogleFonts.lora(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GFButton(
                            onPressed: () {},
                            text: "Calculator",
                            icon: const Icon(Icons.calculate,
                                color: Colors.white, size: 16),
                            color: Appcolor.primary,
                            shape: GFButtonShape.standard,
                            size: GFSize.SMALL,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            textStyle: GoogleFonts.lora(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                // Wrap with Expanded
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 380,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10.0,
                                        spreadRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: const HtmlWidget("""
              <iframe src="https://www.hamropatro.com/widgets/calender-full.php" frameborder="0" scrolling="no" marginwidth="0" marginheight="0"
              style="border:none; overflow:hidden; width:850px !important; " allowtransparency="true"></iframe>
              """),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
