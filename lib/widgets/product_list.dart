import 'package:flutter/material.dart';
import 'package:pagameto_credit_pix/models/product.dart';


class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          subtitle: Text('\$${products[index].price.toString()}'),
          onTap: () {
            // Lógica ao clicar no produto
          },
        );
      },
    );
  }
}
