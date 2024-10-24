import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/proile/profile_bloc.dart';
import 'package:finance/bloc/proile/profile_event.dart';
import 'package:finance/bloc/proile/profile_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(LoadProfile(userId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lora(color: Colors.white),
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
            )),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
                child: LoadingScreen());
          } else if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${state.profileData['name']}',
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  Text('Email: ${state.profileData['email']}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('Phone: ${state.profileData['phone']}',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
