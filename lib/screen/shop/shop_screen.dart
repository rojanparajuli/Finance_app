import 'package:finance/bloc/shop/shop_bloc.dart';
import 'package:finance/bloc/shop/shop_event.dart';
import 'package:finance/bloc/shop/shop_state.dart';
import 'package:finance/model/shop/shop_model.dart';
import 'package:finance/screen/shop/trasection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shops"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add shop form
              _showShopForm(context);
            },
          ),
        ],
      ),
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
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final shop = shops[index];
                return ListTile(
                  title: Text(shop.name),
                  subtitle: Text(shop.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showShopForm(context, shop: shop),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<ShopBloc>(context)
                              .add(DeleteShop(shop.id.toString()));
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => TransactionScreen(shopId: shop.id.toString()),
                    ));
                  },
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
        title: Text(shop == null ? 'Add Shop' : 'Edit Shop'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                if (shop == null) {
                  // Adding a new shop (no id provided)
                  BlocProvider.of<ShopBloc>(context).add(AddShop(Shop(
                    name: name,
                    description: description,
                  )));
                } else {
                  // Editing an existing shop (id already exists)
                  BlocProvider.of<ShopBloc>(context).add(EditShop(Shop(
                    id: shop.id, // Pass the existing shop's id
                    name: name,
                    description: description,
                  )));
                }
                Navigator.pop(context);
              }
            },
            child: Text(shop == null ? 'Add' : 'Update'),
          ),
        ],
      );
    },
  );
}


}
