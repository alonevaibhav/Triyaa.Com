import 'package:flutter/material.dart';
import 'package:triyaa_com/Components/PlantAnalysis/smart_plant_card.dart';
import 'package:triyaa_com/Controller/integrated_plant_service_controller.dart';
import 'package:triyaa_com/Controller/nevigation_controller.dart';

class PlantAnalysisScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // Create a navigatorKey
  late final NavigationmenuController controller; // Declare controller variable

  final String imagePath;
  final IntegratedPlantService plantService;

  PlantAnalysisScreen({
    Key? key,
    required this.imagePath,
    required this.plantService,
  }) : super(key: key) {
    controller = NavigationmenuController(navigatorKey: navigatorKey); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Analysis'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            controller.goBack();  // Use the controller to go back
          },
        ),
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
