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

  Future<Map<String, dynamic>> getCompleteAnalysiss(
      String imagePath, {
        double? latitude,
        double? longitude,
      }) async {
    // Use the latitude and longitude as needed
    // Example: Pass them to an API or perform some logic

    return {
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      // Include your analysis data here
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
