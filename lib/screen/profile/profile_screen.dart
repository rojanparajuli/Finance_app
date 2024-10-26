import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/joke/joke_bloc.dart';
import 'package:finance/bloc/joke/joke_event.dart';
import 'package:finance/bloc/joke/joke_state.dart';
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
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<JokeBloc>().add(LoadJokeOfTheDay());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 160,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/profile_pattern.jpg'),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 - 60,
                        bottom: -50,
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Appcolor.secondary,
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        _buildProfileInfo(
                          title: 'Name',
                          value: state.profileData['name'],
                          isBold: true,
                        ),
                        const SizedBox(height: 10),
                        // Email
                        _buildProfileInfo(
                          title: 'Email',
                          value: state.profileData['email'],
                        ),
                        const SizedBox(height: 10),
                        // Phone
                        _buildProfileInfo(
                          title: 'Phone',
                          value: state.profileData['phone'],
                        ),
                        const SizedBox(height: 20),
                        Divider(color: Colors.grey.shade300),
                        const SizedBox(height: 20),

                        // Joke of the Day Section
                        BlocBuilder<JokeBloc, JokeState>(
                          builder: (context, jokeState) {
                            if (jokeState is JokeLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (jokeState is JokeLoaded) {
                              return _buildJokeOfTheDay(jokeState.joke);
                            } else if (jokeState is JokeError) {
                              return Text(
                                'Error loading joke: ${jokeState.message}',
                                style: GoogleFonts.lora(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: GoogleFonts.lora(
                  fontSize: 18,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // Helper method to build profile info
  Widget _buildProfileInfo({required String title, required dynamic value, bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: GoogleFonts.lora(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Appcolor.primary,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value != null ? value.toString() : 'N/A', // Handle null value
          style: GoogleFonts.lora(
            fontSize: 15,
            color: Appcolor.secondary,
          ),
        ),
      ],
    );
  }

  // Method to build the joke of the day
  Widget _buildJokeOfTheDay(String joke) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Joke of the Day:',
            style: GoogleFonts.lora(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Appcolor.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            joke,
            style: GoogleFonts.lora(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
