import 'package:finance/authentication/bloc/login/login_bloc.dart';
import 'package:finance/bloc/support_page/support_page_bloc.dart';
import 'package:finance/bloc/support_page/support_page_state.dart';
import 'package:finance/bloc/support_page/suuportpage_event.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController _messageController = TextEditingController();
  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _messageController.addListener(() {
      setState(() {}); 
    });
  }

  void _fetchUserId() async {
    userId = await context.read<LoginBloc>().getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Support',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        backgroundColor: Appcolor.primary,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE8F6F3), Color(0xFFEBF2EA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(  
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Us',
                    style: GoogleFonts.lora(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We are here to help! Please reach out to us with any questions or suggestions.',
                    style: GoogleFonts.lora(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Emails:',
                              style: GoogleFonts.lora(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/gmail.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'bishals554@gmail.com',
                                      style: GoogleFonts.lora(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/gmail.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'rojanparajuli14@gmail.com',
                                      style: GoogleFonts.lora(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Website:',
                              style: GoogleFonts.lora(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'rojanparajuli.com.np',
                              style: GoogleFonts.lora(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Your Message',
                    style: GoogleFonts.lora(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                    ),
                    maxLines: 5,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<MessageBloc, MessageState>(
                    listener: (context, state) {
                      if (state is MessageSent) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent!')),
                        );
                        _messageController.clear();
                      } else if (state is MessageError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${state.error}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is MessageSending) {
                        return  Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('assets/animation.json')),
                        );
                      }

                      final isButtonEnabled = userId != null &&
                          _messageController.text.isNotEmpty;

                      return Center(
                        child: ElevatedButton(
                          onPressed: isButtonEnabled
                              ? () {
                                  final content = _messageController.text;
                                  context.read<MessageBloc>().add(SendMessage(
                                      user: userId!, content: content));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isButtonEnabled
                                ? Appcolor.primary
                                : Colors.grey, 
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.3),
                          ),
                          child: Text(
                            'Send Message',
                            style: GoogleFonts.lora(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
