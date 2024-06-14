import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pagameto_credit_pix/models/product.dart';

class ProductRepository {
  final String baseUrl;

  ProductRepository({required this.baseUrl});

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
