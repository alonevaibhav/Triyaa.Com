
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:triyaa_com/Constants/GeminiApiKey.dart';
import 'package:triyaa_com/Model/gemini_api_model.dart';

class PlantDetectionAPI {
  Future<Map<String, dynamic>> fetchPlantInfo(String imagePath) async {
    // const String GEMINIAPI = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=AIzaSyCVpoy2WcLgCeTv8FzHLLPuanXEMDe_5_U';
    final Uri uri = Uri.parse(GEMINIAPI);

    try {
      final File imageFile = File(imagePath);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      // Simplified prompt format to avoid parsing issues
      final GeminiModel body = GeminiModel(
        contents: [
          Contents(parts: [
            Parts(text: """
              Analyze this plant image and provide information in exactly this format:
              COMMON_NAME: <name>
              SCIENTIFIC_NAME: <scientific name>
              ENGLISH_NAME: <english name>
              HINDI_NAME: <hindi name>
              MARATHI_NAME: <marathi name>
              CARE_INSTRUCTIONS:
              Watering: <watering details>
              Sunlight: <sunlight requirements>
              Soil: <soil requirements>
              Maintenance: <general care and maintenance>
            """),
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
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final String plantDescription = jsonResponse['candidates'][0]['content']['parts'][0]['text'];

        // Parse the structured response
        Map<String, String> parsedInfo = _parsePlantInfo(plantDescription);

        // Debug print the full response
        print('Raw API Response: $plantDescription');
        print('Parsed Info: $parsedInfo');

        return {
          'name': parsedInfo['COMMON_NAME'] ?? 'Unknown Plant',
          'scientific': parsedInfo['SCIENTIFIC_NAME'],
          'englishName': parsedInfo['ENGLISH_NAME'],
          'hindiName': parsedInfo['HINDI_NAME'],
          'marathiName': parsedInfo['MARATHI_NAME'],
          'care': _formatCareInstructions(parsedInfo['CARE_INSTRUCTIONS'] ?? ''),
        };
      } else {
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Detailed error: ${e.toString()}');
      throw Exception('Error processing request: $e');
    }
  }

  String _formatCareInstructions(String careInstructions) {
    if (careInstructions.isEmpty) {
      return 'Care instructions not available';
    }

    // Format the care instructions into a more readable structure
    final sections = careInstructions.split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .join('\n\n');

    return sections;
  }

  Map<String, String> _parsePlantInfo(String response) {
    Map<String, String> result = {};
    String currentKey = '';
    List<String> currentValue = [];
    bool isCareInstructions = false;

    // Split response into lines and process
    for (String line in response.split('\n')) {
      line = line.trim();
      if (line.isEmpty) continue;

      // Check if this is a main section header
      if (line.contains(':') && !line.startsWith(' ') && !isCareInstructions) {
        // Save previous section if exists
        if (currentKey.isNotEmpty && currentValue.isNotEmpty) {
          result[currentKey] = currentValue.join('\n').trim();
          currentValue.clear();
        }

        var parts = line.split(':');
        currentKey = parts[0].trim();

        // Check if we're entering care instructions section
        if (currentKey == 'CARE_INSTRUCTIONS') {
          isCareInstructions = true;
          currentValue.clear();
          continue;
        }

        if (parts.length > 1) {
          currentValue.add(parts.sublist(1).join(':').trim());
        }
      } else {
        // If we're in care instructions, collect everything
        if (isCareInstructions) {
          currentValue.add(line);
        } else if (line.isNotEmpty) {
          currentValue.add(line);
        }
      }
    }

    // Add the last section
    if (currentKey.isNotEmpty && currentValue.isNotEmpty) {
      result[currentKey] = currentValue.join('\n').trim();
    }

    return result;
  }
}