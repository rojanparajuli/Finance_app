import 'package:finance/bloc/shop/shop_bloc.dart';
import 'package:finance/bloc/shop/shop_event.dart';
import 'package:finance/bloc/shop/shop_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/model/shop/shop_model.dart';
import 'package:finance/screen/shop/trasection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shops",
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                _showShopForm(context);
              },
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const Drawer(),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShopLoaded) {
            final shops = state.shops;
            if (shops.isEmpty) {
              return const Center(child: Text('No shops available'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final shop = shops[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 2,
                  child: GFListTile(
                    title: Text(
                      shop.name,
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subTitle: Text(
                      shop.description,
                      style: GoogleFonts.lora(fontSize: 16),
                    ),
                    avatar: GFAvatar(
                      backgroundColor: Appcolor.primary,
                      child: Text(
                        shop.name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Appcolor.primary),
                          onPressed: () => _showShopForm(context, shop: shop),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            BlocProvider.of<ShopBloc>(context)
                                .add(DeleteShop(shop.id.toString()));
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TransactionScreen(shopId: shop.id.toString()),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ShopError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void _showShopForm(BuildContext context, {Shop? shop}) {
    final formKey = GlobalKey<FormState>();
    String name = shop?.name ?? '';
    String description = shop?.description ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            shop == null ? 'Add Shop' : 'Edit Shop',
            style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Appcolor.primary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    initialValue: description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Appcolor.primary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSaved: (value) => description = value!,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.lora(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  if (shop == null) {
                    BlocProvider.of<ShopBloc>(context).add(AddShop(Shop(
                      name: name,
                      description: description,
                    )));
                  } else {
                    BlocProvider.of<ShopBloc>(context).add(EditShop(Shop(
                      id: shop.id,
                      name: name,
                      description: description,
                    )));
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(
                shop == null ? 'Add' : 'Update',
                style: GoogleFonts.lora(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
