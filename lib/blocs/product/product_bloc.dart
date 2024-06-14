import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagameto_credit_pix/models/product.dart';
import 'package:pagameto_credit_pix/repositories/product_repository.dart';


abstract class ProductEvent {}
class FetchProducts extends ProductEvent {}

abstract class ProductState {}
class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}
class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProducts) {
      yield ProductLoading();
      try {
        final products = await repository.getProducts();
        yield ProductLoaded(products);
      } catch (e) {
        yield ProductError(e.toString());
      }
    }
  }
}
