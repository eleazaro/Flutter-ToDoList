import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  final String baseUrl = "http://10.0.2.2:5131/api";

  Future<List<dynamic>> get(String endpoint) async {
    try {
      final String url = '$baseUrl$endpoint';
      print('Chamando: $url');

      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
          'Erro ao buscar os dados. Status Code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  Future<void> post(String endpoint, Map<String, dynamic> data) async {
    await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  Future<void> put(String endpoint, Map<String, dynamic> data) async {
    await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  Future<void> delete(String endpoint) async {
    await http.delete(Uri.parse('$baseUrl$endpoint'));
  }
}
