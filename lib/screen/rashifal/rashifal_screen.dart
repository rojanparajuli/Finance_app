import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/rashifal/rashifal_bloc.dart';
import 'package:finance/bloc/rashifal/rashifal_state.dart';
import 'package:google_fonts/google_fonts.dart';

class RashifalScreen extends StatelessWidget {
  final String iframeUrl =
      "https://nepalicalendar.rat32.com/rashifal/embed.php";

  const RashifalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nepali Rashifal',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        backgroundColor: Appcolor.primary,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,)),
      ),
      body: BlocBuilder<RashifalBloc, RashifalState>(
        builder: (context, state) {
          if (state is RashifalLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is RashifalLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: WebUri.uri(Uri.parse(iframeUrl))),
                // ignore: deprecated_member_use
                initialOptions: InAppWebViewGroupOptions(
                  // ignore: deprecated_member_use
                  crossPlatform: InAppWebViewOptions(
                    useOnDownloadStart: true,
                    useShouldOverrideUrlLoading: true,
                    javaScriptEnabled: true,
                    cacheEnabled: true,
                    verticalScrollBarEnabled: true,
                  ),
                ),
                onLoadStop: (controller, url) async {
                  await controller.evaluateJavascript(source: """
                    (function() {
                      var style = document.createElement('style');
                      style.innerHTML = `
                        body {
                          margin: 0;
                          padding: 0;
                        }
                        iframe {
                          width: 100%;
                          min-height: 100vh;
                          border: none;
                          border-radius: 5px;
                          margin: 0;
                          padding: 0;
                        }
                      `;
                      document.head.appendChild(style);
                    })();
                  """);
                },
              ),
            );
          } else if (state is RashifalError) {
            return const Center(child: Text("Failed to load Rashifal"));
          }
          return Container();
        },
      ),
    );
  }
}
