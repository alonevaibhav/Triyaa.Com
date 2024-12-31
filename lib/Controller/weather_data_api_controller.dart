import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  final String apiKey = 'bfc29e1e883c474cb0e190830243012';
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Map<String, dynamic>> fetchWeatherData() async {
    try {
      // Get the user's current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Build the request URL
      final url =
          '$baseUrl?key=$apiKey&q=${position.latitude},${position.longitude}';

      // Make the HTTP GET request
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return {
          'temperature': data['current']['temp_c'],
          'condition': data['current']['condition']['text'],
          'location': '${data['location']['name']}, ${data['location']['region']}',
        };
      } else {
        throw Exception('Failed to fetch weather data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
