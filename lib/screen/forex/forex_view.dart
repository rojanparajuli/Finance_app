import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/forex/forex_bloc.dart';
import 'package:finance/bloc/forex/forex_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class ForexScreen extends StatelessWidget {
  const ForexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Forex Rates', style: GoogleFonts.lora(color: Colors.white),),
      centerTitle: true,
      backgroundColor: Appcolor.primary,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,)),
      ),
     body: BlocBuilder<ForexBloc, ForexState>(
  builder: (context, state) {
    if (state is ForexLoading) {
      return const Center(child: LoadingScreen());
    } else if (state is ForexLoaded) {
      print('ForexLoaded state with rates: ${state.rates}');

      if (state.rates.isEmpty) {
        return const Center(child: Text('No forex rates available.'));
      }

      return ListView.builder(
        itemCount: state.rates.length,
        itemBuilder: (context, index) {
          final rate = state.rates[index];
          print('Displaying rate for: ${rate.currency}');
          return ListTile(
            title: Text(rate.currency),
            subtitle: Text('Buy: ${rate.buy}, Sell: ${rate.sell}'),
          );
        },
      );
    } else if (state is ForexError) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('No data available.'));
  },
),

    );
  }
}
