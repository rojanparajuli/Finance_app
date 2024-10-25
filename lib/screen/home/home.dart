import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/home/home_bloc.dart';
import 'package:finance/bloc/home/home_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/calculator/calculator_screen.dart';
import 'package:finance/screen/lending/lending_list.dart';
import 'package:finance/screen/shop/shop_screen.dart';
import 'package:finance/widget/drawer_items.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Confirm Exit',
                  style: GoogleFonts.lora(),
                ),
                content: Text(
                  'Do you really want to go back?',
                  style: GoogleFonts.lora(),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: GoogleFonts.lora(),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Appcolor.primary),
                    ),
                    child: Text(
                      'Yes',
                      style: GoogleFonts.lora(color: Colors.white),
                    ),
                  )
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Appcolor.primary,
          title: Text(
            "${getGreeting()}, User",
            style: GoogleFonts.lora(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
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
                        // Quote Display
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
                        const Divider(color: Colors.grey, thickness: 1),
                        const SizedBox(height: 30),

                        // Action Buttons
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LendingListPage(),
                                  ),
                                );
                              },
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CalculatorScreen(),
                                  ),
                                );
                              },
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
                        const SizedBox(height: 20),
                        const Divider(color: Colors.black),

                        Container(
                          alignment: Alignment.center,
                          height: 300,
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
                          child: InAppWebView(
                            initialData: InAppWebViewInitialData(
                              data: """
                              <html>
                                <head>
                                  <script async src="https://nepalipatro.com.np/np-widgets/nepalipatro.js" id="wiz1"></script>
                                </head>
                                <body>
                                  <div id="np_widget_wiz1" widget="month"></div>
                                </body>
                              </html>
                              """,
                              mimeType: 'text/html',
                            ),
                            // ignore: deprecated_member_use
                            initialOptions: InAppWebViewGroupOptions(
                              // ignore: deprecated_member_use
                              crossPlatform: InAppWebViewOptions(
                                javaScriptEnabled: true,
                              ),
                            ),
                            onWebViewCreated:
                                (InAppWebViewController controller) {},
                          ),
                        ),
                        const Divider(color: Colors.black),
                        const SizedBox(height: 10),
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
      ),
    );
  }
}
