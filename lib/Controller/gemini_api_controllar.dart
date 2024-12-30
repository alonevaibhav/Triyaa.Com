//
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:triyaa_com/Constants/GeminiApiKey.dart';
// import 'package:triyaa_com/Model/gemini_api_model.dart';
//
// class PlantDetectionAPI {
//   Future<Map<String, dynamic>> fetchPlantInfo(String imagePath) async {
//     try {
//       // Read the image file
//       final File imageFile = File(imagePath);
//       final List<int> imageBytes = await imageFile.readAsBytes();
//
//       // Encode to base64 correctly
//       final String base64Image = base64Encode(imageBytes);
//
//       // Prepare the request body according to Gemini's format
//       final Map<String, dynamic> body = {
//         "contents": [
//           {
//             "parts": [
//               {
//                 "text": "Identify this plant and provide care instructions"
//               },
//               {
//                 "inline_data": {
//                   "mime_type": "image/jpeg",
//                   "data": base64Image
//                 }
//               }
//             ]
//           }
//         ],
//         "generationConfig": {
//           "temperature": 0.4,
//           "topK": 32,
//           "topP": 1,
//           "maxOutputTokens": 4096,
//         }
//       };
//
//
//       // Make the API call
//       final response = await http.post(Uri.parse(GEMINIAPI),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(body),
//       );
//
//       // Print response for debugging
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//
//         // Extract the text response from Gemini
//         final String plantDescription = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
//
//         return {
//           'name': 'Identified Plant',  // You can parse this from the response
//           'description': plantDescription,
//           'care': plantDescription,  // You can parse this from the response
//         };
//       } else {
//         throw Exception('API Error: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       print('Detailed error: $e');  // For debugging
//       throw Exception('Error processing request: $e');
//     }
//   }
// }



// Plant Detection API class



// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:triyaa_com/Constants/GeminiApiKey.dart';
// import 'package:triyaa_com/Model/gemini_api_model.dart';
// //
// class PlantDetectionAPI {
//
//   static const String GEMINIAPI="https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=AIzaSyCVpoy2WcLgCeTv8FzHLLPuanXEMDe_5_U";
//
//   Future<Map<String, dynamic>> fetchPlantInfo(String imagePath) async {
//     try {
//       // Read the image file
//       final File imageFile = File(imagePath);
//       final List<int> imageBytes = await imageFile.readAsBytes();
//
//       // Encode to base64
//       final String base64Image = base64Encode(imageBytes);
//
//       // Construct the request body
//       final GeminiModel body = GeminiModel(
//         contents: [
//           Contents(parts: [
//             Parts(
//               text: "Identify this plant and provide care instructions",
//             ),
//             Parts(
//               inlineData: InlineData(
//                 mimeType: "image/jpeg",
//                 data: base64Image,
//               ),
//             ),
//           ]),
//         ],
//         generationConfig: GenerationConfig(
//           temperature: 0.4,
//           topK: 32,
//           topP: 1,
//           maxOutputTokens: 4096,
//         ),
//       );
//
//       // Make the API call
//       final response = await http.post(
//         Uri.parse(GEMINIAPI),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(body.toJson()),
//       );
//
//       // Print response for debugging
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//
//         // Extract the text response from Gemini
//         final String plantDescription = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
//
//         return {
//           'name': 'Identified Plant',
//           'description': plantDescription,
//           'care': plantDescription,
//         };
//       } else {
//         throw Exception('API Error: ${response.statusCode} - ${response.body}');
//       }
//     }
//     catch (e) {
//       print('Detailed error: $e');
//       throw Exception('Error processing request: $e');
//     }
//   }
// }



import 'package:triyaa_com/Constants/GeminiApiKey.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:triyaa_com/Model/gemini_api_model.dart';

class PlantDetectionAPI {
  Future<Map<String, dynamic>> fetchPlantInfo(String imagePath) async {
    const String GEMINIAPI = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=AIzaSyCVpoy2WcLgCeTv8FzHLLPuanXEMDe_5_U';

    print("heel");
    // Convert the string URL to a Uri object
    final Uri uri = Uri.parse(GEMINIAPI);

    print('Request URL: $GEMINIAPI');

    try {
      // Read the image file
      final File imageFile = File(imagePath);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);
      print("heel");

      final GeminiModel body = GeminiModel(
        contents: [
          Contents(parts: [
            Parts(text: "Identify this plant and provide care instructions"),
            Parts(
              inlineData: InlineData(
                mimeType: "image/jpeg",
                data: base64Image,
              ),
            ),
          ]),
        ],
        generationConfig: GenerationConfig(
          temperature: 0.4,
          topK: 32,
          topP: 1,
          maxOutputTokens: 4096,
        ),
      );

      final response = await http.post(
        uri, // Use the Uri object here
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body.toJson()),
      );

      // Print response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Extract the text response from Gemini
        final String plantDescription = jsonResponse['candidates'][0]['content']['parts'][0]['text'];

        return {
          'name': 'Identified Plant',
          'description': plantDescription,
          'care': plantDescription,
        };
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Detailed error: ${e.toString()}');
      throw Exception('Error processing request: $e');
    }
  }
}
