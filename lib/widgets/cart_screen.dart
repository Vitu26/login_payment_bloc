import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagameto_credit_pix/blocs/cart/cart_bloc.dart';
import 'package:pagameto_credit_pix/widgets/cart_item.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            return Center(child: Text('Your cart is empty'));
          } else if (state is CartUpdated) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return CartItem(product: state.products[index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
