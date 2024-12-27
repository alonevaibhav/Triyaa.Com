// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:triyaa_com/Constants/GeminiApiKey.dart';
// import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
//
// import 'package:triyaa_com/Controller/image_piker.dart';
//
// class PlantDetectionController extends GetxController {
//   final PlantDetectionAPI plantDetectionAPI = PlantDetectionAPI(); // API instance
//   final PlantDetectionService plantDetectionService = PlantDetectionService(); // Image picker service
//
//   var selectedImage = Rxn<XFile>();
//   var isLoading = false.obs;
//   var plantInfo = Rxn<Map<String, dynamic>>();
//
//   Future<void> pickImageAndDetectPlant(ImageSource source) async {
//     selectedImage.value = await plantDetectionService.pickImage(source);
//     if (selectedImage.value != null) {
//       isLoading.value = true; // Start loading
//       try {
//         final plantData = await plantDetectionAPI.fetchPlantInfo(selectedImage.value!.path);
//         plantInfo.value = plantData; // Update the plant information
//       } catch (e) {
//         print("Error fetching plant info: $e");
//         // Handle error appropriately, show error message, etc.
//       }
//       isLoading.value = false; // Stop loading
//     }
//   }
// }


import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
import 'package:triyaa_com/Controller/image_piker.dart';
import 'package:triyaa_com/Model/gemini_api_model.dart';

class PlantDetectionController extends GetxController {


  final PlantDetectionAPI plantDetectionAPI = PlantDetectionAPI();
  final PlantDetectionService plantDetectionService = PlantDetectionService();

  var selectedImage = Rxn<XFile>();
  var isLoading = false.obs;
  var plantInfo = Rxn<Map<String, dynamic>>();
  var errorMessage = ''.obs;

  Future<void> pickImageAndDetectPlant(ImageSource source) async {
    print("loo");
    try {
      print("bob");
      selectedImage.value = await plantDetectionService.pickImage(source);

      if (selectedImage.value != null) {
        isLoading.value = true;

        print("xo");

        // Verify file exists and is readable
        final file = File(selectedImage.value!.path);
        if (!await file.exists()) {
          throw Exception('Image file not found');
        }
        print("noo");

        final plantData = await plantDetectionAPI.fetchPlantInfo(selectedImage.value!.path);
        plantInfo.value = plantData;
        errorMessage.value = '';
        print("goo");

      }
    } catch (e) {
      errorMessage.value = 'Failed to process image: ${e.toString()}';
      plantInfo.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}