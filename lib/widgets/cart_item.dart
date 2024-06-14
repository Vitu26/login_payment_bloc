import 'package:flutter/material.dart';
import 'package:pagameto_credit_pix/models/product.dart';

class CartItem extends StatelessWidget {
  final Product product;

  CartItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toString()}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_shopping_cart),
        onPressed: () {
          // Lógica para remover do carrinho
        },
      ),
    );
  }
}
