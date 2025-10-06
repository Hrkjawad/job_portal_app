import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseurl;
  ApiService(this._baseurl);
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(_baseurl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['products'] ?? [];
    } else {
      throw Exception("Failed to load jobs");
    }
  }
}
