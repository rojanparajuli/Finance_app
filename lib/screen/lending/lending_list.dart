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
          ),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
        actions: [GestureDetector( onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LendingAddPage()),
          );
        },child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.add, color: Colors.white, size: 30,),
        ))],
      ),
      body: BlocBuilder<LendingBloc, LendingState>(
        builder: (context, state) {
          if (state is LendingLoaded) {
            final totalAmount = state.lendings.fold<double>(
              0,
              (sum, lending) => sum + lending.amount,
            );

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs. $totalAmount',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    
    );
  }
}
