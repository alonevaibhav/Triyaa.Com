// Plant growth requirements model
class PlantRequirements {
  final double minTemp;
  final double maxTemp;
  final int minSunlight; // hours per day
  final List<String> idealMonths;
  final bool isIndoorSuitable;
  final bool isOutdoorSuitable;
  final Map<String, String> growthStages;

  PlantRequirements({
    required this.minTemp,
    required this.maxTemp,
    required this.minSunlight,
    required this.idealMonths,
    required this.isIndoorSuitable,
    required this.isOutdoorSuitable,
    required this.growthStages,
  });
}