import 'package:finance/model/shop/shop_model.dart';

abstract class ShopEvent {}

class LoadShops extends ShopEvent {}

class AddShop extends ShopEvent {
  final Shop shop;

  AddShop(this.shop);
}

class EditShop extends ShopEvent {
  final Shop shop;

  EditShop(this.shop);
}

class DeleteShop extends ShopEvent {
  final String shopId;

  DeleteShop(this.shopId);
}
