import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class
PlantDetectionAPI {
  final String apiKey = 'AIzaSyC8FZPhje5zdA1xhGtBcNTaIei_8_B-eWg';
  final String apiSecret = 'YOUR_API_SECRET'; // Use appropriate secret if needed
  final String baseUrl = 'https://api.plantdetection.com'; // Replace with actual API URL

  Future<Map<String, dynamic>> fetchPlantInfo(String imagePath) async {
    final url = Uri.parse('$baseUrl/v1/detect-plant');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final requestBody = {
      'image': imagePath, // Assume imagePath is the file path of the image
    };

    final response = await http.post(url, headers: headers, body: json.encode(requestBody));
    if (response.statusCode == 200||response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load plant data');
    }
  }

  String _generateSignature(String path) {
    final payload = json.encode({'request': path});
    final secret = apiSecret; // Plant detection API Secret
    final bytes = utf8.encode(payload);
    final hmacSha384 = Hmac(sha384, utf8.encode(secret)); // HMAC for signature
    final signature = hmacSha384.convert(bytes).toString();
    return signature;
  }
}
