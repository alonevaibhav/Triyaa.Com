import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Components/%20bottom_navigation/bottomNav.dart';
import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
import 'package:triyaa_com/Controller/image_piker.dart';
import 'package:triyaa_com/Controller/navigation_controller.dart';
import 'package:triyaa_com/Controller/weather_data_api_controller.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/plant_analysis_page.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/plant_detection_page.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigationController controller = Get.put(NavigationController());
  XFile? pickedFile;

  @override
  void initState() {
    super.initState();
    _pickImage(); // Trigger image picking asynchronously.
  }

  Future<void> _pickImage() async {
    try {
      XFile? file = await PlantDetectionService().pickImage(ImageSource.camera);
      setState(() {
        pickedFile = file;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex,
        children: [
          pickedFile != null
              ? PlantAnalysisScreen(
            imagePath: pickedFile!.path, // Pass the picked image path
            plantService: IntegratedPlantService(
              weatherService: WeatherService(),
              plantDetectionAPI: PlantDetectionAPI(),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(), // Show a loader until the image is picked
          ),
          Center(child: PlantDetectionScreen()),
          Center(child: ProfilePage()),
        ],
      )),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
