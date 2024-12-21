import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Controller/GeminiAPI.dart';

import 'package:triyaa_com/Controller/image_piker.dart';

class PlantDetectionController extends GetxController {
  final PlantDetectionAPI plantDetectionAPI = PlantDetectionAPI(); // API instance
  final PlantDetectionService plantDetectionService = PlantDetectionService(); // Image picker service

  var selectedImage = Rxn<XFile>();
  var isLoading = false.obs;
  var plantInfo = Rxn<Map<String, dynamic>>();

  Future<void> pickImageAndDetectPlant(ImageSource source) async {
    selectedImage.value = await plantDetectionService.pickImage(source);
    if (selectedImage.value != null) {
      isLoading.value = true; // Start loading
      try {
        final plantData = await plantDetectionAPI.fetchPlantInfo(selectedImage.value!.path);
        plantInfo.value = plantData; // Update the plant information
      } catch (e) {
        print("Error fetching plant info: $e");
        // Handle error appropriately, show error message, etc.
      }
      isLoading.value = false; // Stop loading
    }
  }
}

