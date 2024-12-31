import 'package:flutter/material.dart';
import 'package:triyaa_com/Controller/weather_data_api_controller.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  bool _isLoading = true;
  Map<String, dynamic>? _weatherData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await _weatherService.fetchWeatherData();
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _buildWeatherInfo(),
    );
  }

  Widget _buildWeatherInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Location: ${_weatherData!['location']}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Temperature: ${_weatherData!['temperature']}°C',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Condition: ${_weatherData!['condition']}',
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
