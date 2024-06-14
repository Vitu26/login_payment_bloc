import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagameto_credit_pix/models/product.dart';


abstract class CartEvent {}
class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);
}
class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);
}

abstract class CartState {}
class CartInitial extends CartState {
  final List<Product> products;

  CartInitial(this.products);
}
class CartUpdated extends CartState {
  final List<Product> products;

  CartUpdated(this.products);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> _products = [];

  CartBloc() : super(CartInitial([]));

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddToCart) {
      _products.add(event.product);
      yield CartUpdated(List.from(_products));
    } else if (event is RemoveFromCart) {
      _products.remove(event.product);
      yield CartUpdated(List.from(_products));
    }
  }
}
