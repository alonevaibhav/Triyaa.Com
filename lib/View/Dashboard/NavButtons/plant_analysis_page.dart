import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
import 'package:triyaa_com/Controller/weather_data_api_controller.dart';

// Integrated Service that combines Weather and Plant Detection
class IntegratedPlantService {
  final WeatherService _weatherService;
  final PlantDetectionAPI _plantDetectionAPI;

  IntegratedPlantService({
    required WeatherService weatherService,
    required PlantDetectionAPI plantDetectionAPI,
  })  : _weatherService = weatherService,
        _plantDetectionAPI = plantDetectionAPI;

  Future<Map<String, dynamic>> getCompleteAnalysis(String imagePath) async {
    // Fetch both plant and weather data concurrently
    final Future<Map<String, dynamic>> plantFuture = _plantDetectionAPI.fetchPlantInfo(imagePath);
    final Future<Map<String, dynamic>> weatherFuture = _weatherService.fetchWeatherData();

    // Wait for both futures to complete
    final results = await Future.wait([plantFuture, weatherFuture]);
    final plantData = results[0];
    final weatherData = results[1];

    // Analyze optimal growing conditions
    final analysis = _analyzeGrowingConditions(plantData, weatherData);

    return {
      ...plantData,
      ...weatherData,
      ...analysis,
    };
  }

  Map<String, dynamic> _analyzeGrowingConditions(
      Map<String, dynamic> plantData,
      Map<String, dynamic> weatherData,
      ) {
    final careInstructions = plantData['care'] as String;
    final currentTemp = weatherData['temperature'] as double;

    // Extract temperature preferences from care instructions
    final tempRange = _extractTemperatureRange(careInstructions);
    final sunlightNeeds = _extractSunlightNeeds(careInstructions);

    // Calculate season suitability score
    final seasonScore = _calculateSeasonalScore(
      currentTemp: currentTemp,
      idealMinTemp: tempRange['min'] ?? 15.0,
      idealMaxTemp: tempRange['max'] ?? 30.0,
    );

    return {
      'seasonalScore': seasonScore,
      'seasonalAdvice': _getSeasonalAdvice(seasonScore),
      'recommendedLocation': _getLocationRecommendation(
        currentTemp,
        tempRange['min'] ?? 15.0,
        tempRange['max'] ?? 30.0,
        sunlightNeeds,
      ),
      'careRecommendations': _generateCareRecommendations(
        currentTemp,
        tempRange['min'] ?? 15.0,
        tempRange['max'] ?? 30.0,
        weatherData['condition'] as String,
        sunlightNeeds,
      ),
    };
  }

  Map<String, double> _extractTemperatureRange(String careInstructions) {
    // Simple temperature extraction logic - can be enhanced
    final tempRegex = RegExp(r'(\d+).*?(\d+).*?degrees|°C|°F');
    final match = tempRegex.firstMatch(careInstructions);

    if (match != null) {
      return {
        'min': double.parse(match.group(1)!),
        'max': double.parse(match.group(2)!),
      };
    }

    return {'min': 15.0, 'max': 30.0}; // Default range
  }

  String _extractSunlightNeeds(String careInstructions) {
    if (careInstructions.toLowerCase().contains('full sun')) return 'full sun';
    if (careInstructions.toLowerCase().contains('partial shade')) return 'partial shade';
    if (careInstructions.toLowerCase().contains('shade')) return 'shade';
    return 'moderate light';
  }

  double _calculateSeasonalScore(
      {required double currentTemp,
        required double idealMinTemp,
        required double idealMaxTemp}) {
    if (currentTemp >= idealMinTemp && currentTemp <= idealMaxTemp) {
      return 100.0;
    }

    final midRange = (idealMaxTemp + idealMinTemp) / 2;
    final tempDiff = (currentTemp - midRange).abs();
    final maxDiff = (idealMaxTemp - idealMinTemp);

    return 100.0 * (1 - (tempDiff / maxDiff));
  }

  String _getSeasonalAdvice(double score) {
    if (score >= 80) return "Perfect growing conditions!";
    if (score >= 60) return "Good conditions with some care needed";
    if (score >= 40) return "Challenging conditions - extra attention required";
    return "Consider indoor growing or waiting for better conditions";
  }

  String _getLocationRecommendation(
      double currentTemp,
      double minTemp,
      double maxTemp,
      String sunlightNeeds,
      ) {
    if (currentTemp < minTemp || currentTemp > maxTemp) {
      return "Indoor growing recommended for temperature control";
    }

    if (sunlightNeeds == 'full sun') {
      return "Outdoor growing recommended in a sunny location";
    }

    return "Can be grown both indoor and outdoor with proper care";
  }

  List<String> _generateCareRecommendations(
      double currentTemp,
      double minTemp,
      double maxTemp,
      String weatherCondition,
      String sunlightNeeds,
      ) {
    List<String> recommendations = [];

    if (currentTemp < minTemp) {
      recommendations.add(
        "Temperature is below optimal range. Consider moving to a warmer location or providing heat.",
      );
    }

    if (currentTemp > maxTemp) {
      recommendations.add(
        "Temperature is above optimal range. Provide shade and increase ventilation.",
      );
    }

    if (weatherCondition.toLowerCase().contains('rain')) {
      recommendations.add(
        "Rainy conditions - ensure proper drainage and watch for root rot.",
      );
    }

    if (sunlightNeeds == 'full sun' &&
        weatherCondition.toLowerCase().contains('cloudy')) {
      recommendations.add(
        "Cloudy conditions - consider supplemental lighting for optimal growth.",
      );
    }

    return recommendations;
  }
}

// Beautiful UI Component
class SmartPlantCard extends StatelessWidget {
  final Map<String, dynamic> analysisData;
  final String imagePath;

  const SmartPlantCard({
    Key? key,
    required this.analysisData,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plant Image and Basic Info Header
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.file(
                  File(imagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        analysisData['name'] ?? 'Unknown Plant',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        analysisData['scientific'] ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Weather and Location Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    analysisData['location'] ?? 'Location unknown',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${analysisData['temperature']}°C',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          // Season Suitability Score
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircularPercentIndicator(
                  radius: 30,
                  lineWidth: 8,
                  percent: (analysisData['seasonalScore'] as double) / 100,
                  center: Text(
                    "${(analysisData['seasonalScore'] as double).toInt()}%",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  progressColor: _getScoreColor(analysisData['seasonalScore']),
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Growing Conditions",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        analysisData['seasonalAdvice'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Names in Different Languages
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Known As",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (analysisData['englishName'] != null)
                      _buildNameRow("English", analysisData['englishName']),
                    if (analysisData['hindiName'] != null)
                      _buildNameRow("Hindi", analysisData['hindiName']),
                    if (analysisData['marathiName'] != null)
                      _buildNameRow("Marathi", analysisData['marathiName']),
                  ],
                ),
              ),
            ),
          ),

          // Care Recommendations
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Care Recommendations",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...(analysisData['careRecommendations'] as List<String>)
                    .map((recommendation) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.eco_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(recommendation),
                      ),
                    ],
                  ),
                ))
                    .toList(),
              ],
            ),
          ),

          // Detailed Care Instructions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detailed Care Guide",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(analysisData['care'] ?? 'No care instructions available'),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.3, end: 0);
  }

  Widget _buildNameRow(String language, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              language,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(name),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    if (score >= 40) return Colors.amber;
    return Colors.red;
  }
}

// Example Usage Screen
class PlantAnalysisScreen extends StatelessWidget {
  final String imagePath;
  final IntegratedPlantService plantService;

  const PlantAnalysisScreen({
    Key? key,
    required this.imagePath,
    required this.plantService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Analysis'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: plantService.getCompleteAnalysis(imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SmartPlantCard(
              analysisData: snapshot.data!,
              imagePath: imagePath,
            ),
          );
        },
      ),
    );
  }
}