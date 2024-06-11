import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class AuthRepository {
  final String apiUrl = 'http://api.example.com/auth';

  Future<User> authenticate(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<User> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
