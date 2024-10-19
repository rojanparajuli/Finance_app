import 'package:finance/animation/widget/shimmer_loading.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.primary,
        title: const Text('Loading...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 8, // Number of shimmer cards
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ShimmerLoadingCard(),
            );
          },
        ),
      ),
    );
  }
}