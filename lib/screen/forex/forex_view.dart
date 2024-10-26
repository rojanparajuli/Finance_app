import 'package:finance/animation/loading_screen.dart';
import 'package:finance/bloc/forex/forex_bloc.dart';
import 'package:finance/bloc/forex/forex_event.dart';
import 'package:finance/bloc/forex/forex_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ForexScreen extends StatefulWidget {
  const ForexScreen({super.key});

  @override
  _ForexScreenState createState() => _ForexScreenState();
}

class _ForexScreenState extends State<ForexScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    context.read<ForexBloc>().add(FetchForexRates(from: '2024-01-01', to: '2077-12-31'));

    _scrollController.addListener(_onScroll);
    _searchController.addListener(() {
      context.read<ForexBloc>().add(UpdateSearchQuery(_searchController.text));
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      _currentPage++;
      context.read<ForexBloc>().add(LoadMoreForexRates(
        from: '2024-01-01',
        to: '2077-12-31',
        page: _currentPage,
        perPage: _perPage,
      ));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forex Rates',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Currency',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Appcolor.primary),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<ForexBloc, ForexState>(
                builder: (context, state) {
                  if (state is ForexLoading && _currentPage == 1) {
                    return const Center(child: LoadingScreen());
                  } else if (state is ForexLoaded) {
                    if (state.rates.isEmpty) {
                      return const Center(child: Text('No forex rates available.'));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.rates.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.rates.length) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final rate = state.rates[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              rate.currency,
                              style: GoogleFonts.lora(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Buy: ${rate.buy} | Sell: ${rate.sell} | Unit: ${rate.unit}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ForexError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No data available.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
