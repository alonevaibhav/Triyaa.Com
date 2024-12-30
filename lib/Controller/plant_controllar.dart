import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
import 'package:triyaa_com/Controller/image_piker.dart';

class PlantDetectionController extends GetxController {
  final PlantDetectionAPI plantDetectionAPI = PlantDetectionAPI();
  final PlantDetectionService plantDetectionService = PlantDetectionService();

  var selectedImage = Rxn<XFile>();
  var isLoading = false.obs;
  var plantInfo = Rxn<Map<String, dynamic>>();
  var errorMessage = ''.obs;

  Future<void> pickImageAndDetectPlant(ImageSource source) async {
    try {
      selectedImage.value = await plantDetectionService.pickImage(source);

      if (selectedImage.value != null) {
        isLoading.value = true;

        // Verify file exists and is readable
        final file = File(selectedImage.value!.path);
        if (!await file.exists()) {
          throw Exception('Image file not found');
        }

        final plantData =
            await plantDetectionAPI.fetchPlantInfo(selectedImage.value!.path);
        plantInfo.value = plantData;
        errorMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Failed to process image: ${e.toString()}';
      plantInfo.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
