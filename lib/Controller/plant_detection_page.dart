// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:http/http.dart 'as http;
//
// class PlantDetectionController extends GetxController {
//   var selectedImage = Rxn<String>(); // File path as a string
//   var isLoading = false.obs;
//   var plantInfo = Rxn<Map<String, dynamic>>();
//
//   final Gemini gemini = Gemini.instance; // Gemini API instance
//
//   Future<void> pickFileAndDetectPlant() async {
//     try {
//       // Pick a file using File Picker
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.image, // Restrict to image files
//         allowMultiple: false,
//       );
//
//       if (result != null && result.files.single.path != null) {
//         final String filePath = result.files.single.path!;
//         selectedImage.value = filePath;
//         isLoading.value = true; // Start loading
//
//         // Use the Gemini API for plant detection
//         final response = await gemini.detectPlant(imagePath: filePath);
//         plantInfo.value = {
//           'name': response.name,
//           'scientific': response.scientificName,
//           'care': response.careInstructions,
//         }; // Map the response to plantInfo
//       }
//     } catch (e) {
//       print("Error detecting plant: $e");
//     } finally {
//       isLoading.value = false; // Stop loading
//     }
//   }
// }
//
// Future<Map<String, dynamic>?> detectPlant({Uint8List? bytes, String? path}) async {
//   try {
//     isLoading.value = true;
//
//     // Use flutter_gemini for plant detection
//     final result = bytes != null
//         ? await Gemini.detectPlantFromBytes(bytes)
//         : await Gemini.detectPlantFromFile(File(path!));
//
//     return result;
//   } catch (e) {
//     print('Plant detection error: $e');
//     return null;
//   } finally {
//     isLoading.value = false;
//   }
// }
//
//
// extension on Gemini {
//   detectPlant({required String imagePath}) {}
// }
