// import 'package:flutter/material.dart';
// import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
// import 'package:triyaa_com/Controller/weather_data_api_controller.dart';
//
// class PlantWeatherAnalyzer {
//   final WeatherService weatherService = WeatherService();
//   final PlantDetectionAPI plantDetectionAPI = PlantDetectionAPI();
//
//   Future<Map<String, dynamic>> analyzePlantAndWeather(String imagePath) async {
//     try {
//       // Fetch weather data
//       final weatherData = await weatherService.fetchWeatherData();
//
//       // Fetch plant data
//       final plantData = await plantDetectionAPI.fetchPlantInfo(imagePath);
//
//       // Analyze combined data
//       final analysis = _analyzeData(weatherData, plantData);
//
//       return {
//         'weather': weatherData,
//         'plant': plantData,
//         'analysis': analysis,
//       };
//     } catch (e) {
//       throw Exception('Error analyzing plant and weather data: $e');
//     }
//   }
//
//   Map<String, String> _analyzeData(
//       Map<String, dynamic> weatherData, Map<String, dynamic> plantData) {
//     final String currentCondition = weatherData['condition'].toLowerCase();
//     final double currentTemperature = weatherData['temperature'];
//
//     // Sample plant conditions
//     final String sunlight = plantData['care']['Sunlight'] ?? '';
//     final String watering = plantData['care']['Watering'] ?? '';
//     final String soil = plantData['care']['Soil'] ?? '';
//
//     String isGoodSeason = 'No';
//     String suggestedSeason = 'Unknown';
//     String indoorOutdoor = 'Unknown';
//     String lifecycle = 'Unknown';
//
//     // Example analysis: Check if current weather matches plant requirements
//     if (currentCondition.contains('sun') && sunlight.contains('full')) {
//       isGoodSeason = 'Yes';
//     }
//     if (currentTemperature >= 20 && currentTemperature <= 30) {
//       isGoodSeason = 'Yes';
//     }
//
//     // Example logic for indoor/outdoor suggestion
//     indoorOutdoor =
//     sunlight.toLowerCase().contains('partial') ? 'Indoor' : 'Outdoor';
//
//     // Example lifecycle mapping
//     lifecycle = "Plant lifecycle: Start seeding in Spring";
//
//     return {
//       'isGoodSeason': isGoodSeason,
//       'suggestedSeason': suggestedSeason,
//       'indoorOutdoor': indoorOutdoor,
//       'lifecycle': lifecycle,
//     };
//   }
// }

import 'package:triyaa_com/Model/analysis_.dart';
import 'package:triyaa_com/Model/plant_growth.dart';

class PlantAnalysis {
  // Main analysis method
  static PlantAnalysisResult analyzePlantConditions({
  required PlantRequirements plantData,
  required Map<String, dynamic> weatherData,
  required DateTime currentDate,
  required Map<String, dynamic> locationData,
  }) {
  // Calculate season suitability
  bool isSeasonSuitable = _checkSeasonSuitability(
  plantData,
  weatherData,
  currentDate,
  );

  // Determine best months based on location and weather patterns
  List<String> bestMonths = _calculateBestMonths(
  plantData,
  locationData,
  weatherData,
  );

  // Calculate location recommendation
  String locationRecommendation = _determineIdealLocation(
  plantData,
  weatherData,
  locationData,
  );

  // Determine current growth stage
  String growthStage = _determineGrowthStage(
  plantData,
  currentDate,
  );

  // Generate care recommendations
  List<String> careRecommendations = _generateCareRecommendations(
  plantData,
  weatherData,
  locationData,
  currentDate,
  );

  // Calculate overall season match score (0-100)
  double seasonalScore = _calculateSeasonalScore(
  plantData,
  weatherData,
  currentDate,
  );

  return PlantAnalysisResult(
  isSeasonSuitable: isSeasonSuitable,
  seasonalAdvice: _generateSeasonalAdvice(isSeasonSuitable, seasonalScore),
  bestMonthsToPlant: bestMonths,
  recommendedLocation: locationRecommendation,
  currentGrowthStage: growthStage,
  careRecommendations: careRecommendations,
  seasonalMatchScore: seasonalScore,
  );
  }

  // Helper methods
  static bool _checkSeasonSuitability(
  PlantRequirements plant,
  Map<String, dynamic> weather,
  DateTime date,
  ) {
  double currentTemp = weather['temperature'] as double;
  bool tempInRange = currentTemp >= plant.minTemp && currentTemp <= plant.maxTemp;

  String currentMonth = _getMonthName(date.month);
  bool isIdealMonth = plant.idealMonths.contains(currentMonth);

  return tempInRange && isIdealMonth;
  }

  static List<String> _calculateBestMonths(
  PlantRequirements plant,
  Map<String, dynamic> location,
  Map<String, dynamic> weather,
  ) {
  // Filter ideal months based on location climate data
  return plant.idealMonths.where((month) {
  // Add your climate zone and historical weather analysis logic here
  return true; // Placeholder
  }).toList();
  }

  static String _determineIdealLocation(
  PlantRequirements plant,
  Map<String, dynamic> weather,
  Map<String, dynamic> location,
  ) {
  if (!plant.isIndoorSuitable && !plant.isOutdoorSuitable) {
  return "This plant may not be suitable for your location";
  }

  double currentTemp = weather['temperature'] as double;
  int humidity = weather['humidity'] as int;

  bool harshOutdoorConditions = currentTemp < plant.minTemp ||
  currentTemp > plant.maxTemp ||
  humidity < 30;

  if (harshOutdoorConditions && plant.isIndoorSuitable) {
  return "Indoor growing recommended";
  } else if (plant.isOutdoorSuitable) {
  return "Outdoor growing recommended";
  } else {
  return "Indoor growing required";
  }
  }

  static String _determineGrowthStage(
  PlantRequirements plant,
  DateTime currentDate,
  ) {
  // Implement growth stage calculation based on planting date
  // and current date
  return plant.growthStages[_getMonthName(currentDate.month)] ??
  "Growth stage unknown";
  }

  static List<String> _generateCareRecommendations(
  PlantRequirements plant,
  Map<String, dynamic> weather,
  Map<String, dynamic> location,
  DateTime currentDate,
  ) {
  List<String> recommendations = [];

  double currentTemp = weather['temperature'] as double;
  int humidity = weather['humidity'] as int;

  if (currentTemp < plant.minTemp) {
  recommendations.add(
  "Temperature is below optimal range. Consider moving plant to a warmer location."
  );
  }

  if (currentTemp > plant.maxTemp) {
  recommendations.add(
  "Temperature is above optimal range. Provide shade and increase ventilation."
  );
  }

  // Add more conditional recommendations based on weather and plant needs

  return recommendations;
  }

  static double _calculateSeasonalScore(
  PlantRequirements plant,
  Map<String, dynamic> weather,
  DateTime currentDate,
  ) {
  double score = 0.0;

  // Temperature match (40% of score)
  double currentTemp = weather['temperature'] as double;
  double tempRange = plant.maxTemp - plant.minTemp;
  double tempScore = 40.0 * (1 - (currentTemp - plant.minTemp).abs() / tempRange);

  // Season match (40% of score)
  String currentMonth = _getMonthName(currentDate.month);
  double seasonScore = plant.idealMonths.contains(currentMonth) ? 40.0 : 0.0;

  // Additional factors (20% of score)
  double additionalScore = 20.0; // Adjust based on other factors

  return tempScore + seasonScore + additionalScore;
  }

  static String _generateSeasonalAdvice(bool isSuitable, double score) {
  if (score >= 80) {
  return "Excellent conditions for this plant";
  } else if (score >= 60) {
  return "Good conditions with some care needed";
  } else if (score >= 40) {
  return "Challenging conditions - extra care required";
  } else {
  return "Not recommended for current conditions";
  }
  }

  static String _getMonthName(int month) {
  const months = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];
  return months[month - 1];
  }
}
