
// Analysis result model
class PlantAnalysisResult {
  final bool isSeasonSuitable;
  final String seasonalAdvice;
  final List<String> bestMonthsToPlant;
  final String recommendedLocation;
  final String currentGrowthStage;
  final List<String> careRecommendations;
  final double seasonalMatchScore;

  PlantAnalysisResult({
    required this.isSeasonSuitable,
    required this.seasonalAdvice,
    required this.bestMonthsToPlant,
    required this.recommendedLocation,
    required this.currentGrowthStage,
    required this.careRecommendations,
    required this.seasonalMatchScore,
  });
}
