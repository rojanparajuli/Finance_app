import 'package:finance/model/shop/shop_model.dart';

abstract class ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Shop> shops;

  ShopLoaded(this.shops);
}

class ShopError extends ShopState {
  final String message;

  ShopError(this.message);
}
