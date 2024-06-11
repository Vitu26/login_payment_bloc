import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/payment_request.dart';

class PaymentRepository {
  static const String _baseUrl = 'https://seu-backend-url/payment';

  Future<void> processPayment(PaymentRequest paymentRequest) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(paymentRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // Pagamento realizado com sucesso
      print('Pagamento realizado com sucesso');
    } else {
      // Erro ao processar pagamento
      throw Exception('Erro ao processar pagamento');
    }
  }
}
