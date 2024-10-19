import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/bloc/shop/shop_event.dart';
import 'package:finance/bloc/shop/shop_state.dart';
import 'package:finance/model/shop/shop_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final FirebaseFirestore firestore;

  ShopBloc(this.firestore) : super(ShopLoading()) {
    on<LoadShops>(_onLoadShops);
    on<AddShop>(_onAddShop);
    on<EditShop>(_onEditShop);
    on<DeleteShop>(_onDeleteShop);
  }

  Future<void> _onLoadShops(LoadShops event, Emitter<ShopState> emit) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('shops').get();
      List<Shop> shops = snapshot.docs.map((doc) => Shop.fromFirestore(doc)).toList();
      emit(ShopLoaded(shops));
    } catch (e) {
      emit(ShopError('Failed to load shops.'));
    }
  }

  Future<void> _onAddShop(AddShop event, Emitter<ShopState> emit) async {
    try {
      await firestore.collection('shops').add(event.shop.toMap());
      add(LoadShops());
    } catch (e) {
      emit(ShopError('Failed to add shop.'));
    }
  }

  Future<void> _onEditShop(EditShop event, Emitter<ShopState> emit) async {
    try {
      await firestore.collection('shops').doc(event.shop.id).update(event.shop.toMap());
      add(LoadShops());
    } catch (e) {
      emit(ShopError('Failed to edit shop.'));
    }
  }

  Future<void> _onDeleteShop(DeleteShop event, Emitter<ShopState> emit) async {
    try {
      await firestore.collection('shops').doc(event.shopId).delete();
      add(LoadShops());
    } catch (e) {
      emit(ShopError('Failed to delete shop.'));
    }
  }
}
