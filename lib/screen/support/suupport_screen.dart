import 'package:finance/bloc/support_page/support_page_bloc.dart';
import 'package:finance/bloc/support_page/support_page_state.dart';
import 'package:finance/bloc/support_page/suuportpage_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportPage extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();

  SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Email: rojanparahuli14@gmail.com'),
            const Text('Email: bishals554@gmail.com'),
            const Text('Domain: rojanparajuli.com.np'),
            const SizedBox(height: 20),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Your Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
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
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    const email = 'user@example.com'; // Replace with actual user email
                    final content = _messageController.text;
                    if (content.isNotEmpty) {
                      context.read<MessageBloc>().add(SendMessage(email: email, content: content));
                    }
                  },
                  child: const Text('Send Message'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
