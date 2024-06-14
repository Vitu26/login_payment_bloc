import 'package:pagameto_credit_pix/models/product.dart';

abstract class CartState {}

class CartInitial extends CartState {
  final List<Product> products;

  CartInitial(this.products);
}

class CartUpdated extends CartState {
  final List<Product> products;

  CartUpdated(this.products);
}
