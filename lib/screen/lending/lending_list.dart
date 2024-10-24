import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/lending/lending_bloc.dart';
import 'package:finance/bloc/lending/lending_event.dart';
import 'package:finance/bloc/lending/lending_statee.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/lending/add_lending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LendingListPage extends StatelessWidget {
  const LendingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Lending Tracker',
            style: GoogleFonts.lora(color: Colors.white),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: Appcolor.primary),
      body: BlocBuilder<LendingBloc, LendingState>(
        builder: (context, state) {
          if (state is LendingLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.lendings.length,
              itemBuilder: (context, index) {
                final lending = state.lendings[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      lending.name,
                      style: GoogleFonts.lora(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Amount: Rs.${lending.amount}',
                      style: GoogleFonts.lora(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LendingAddPage(lending: lending),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<LendingBloc>()
                                .add(DeleteLendingEvent(lending.id));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is LendingError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: GoogleFonts.lora(fontSize: 18, color: Colors.red),
              ),
            );
          }
          return const Center(child: LoadingScreen());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LendingAddPage()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
