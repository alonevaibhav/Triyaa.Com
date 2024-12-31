import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Controller/gemini_api_controllar.dart';
import 'package:triyaa_com/Controller/image_piker.dart';
import 'package:triyaa_com/Controller/weather_data_api_controller.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/plant_analysis_page.dart';

class MiddleButton extends StatefulWidget {
  const MiddleButton({super.key});

  @override
  State<MiddleButton> createState() => _MiddleButtonState();
}

class _MiddleButtonState extends State<MiddleButton> {
  final Rx<XFile?> _pickedFile = Rx<XFile?>(null);

  Future<void> _pickImage(ImageSource source) async {
    try {
      XFile? file = await PlantDetectionService().pickImage(source);
      _pickedFile.value = file;
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Widget _buildImageButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'Open Gallery',
              Icons.photo_library,
                  () => _pickImage(ImageSource.gallery),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              'Take Photo',
              Icons.camera_alt,
                  () => _pickImage(ImageSource.camera),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 105,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF4A6741)),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF4A6741), size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4A6741),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorationLeaf(double angle, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: angle,
        child: Icon(
          Icons.eco,
          size: 100,
          color: const Color(0xFF4A6741).withOpacity(0.1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() => _pickedFile.value != null
            ? PlantAnalysisScreen(
          imagePath: _pickedFile.value!.path,
          plantService: IntegratedPlantService(
            weatherService: WeatherService(),
            plantDetectionAPI: PlantDetectionAPI(),
          ),
        )
            : Stack(
          children: [
            // Background decorative elements
            _buildDecorationLeaf(0.5, Alignment.topLeft),
            _buildDecorationLeaf(-0.5, Alignment.topRight),
            _buildDecorationLeaf(2.0, Alignment.bottomLeft),
            _buildDecorationLeaf(-2.0, Alignment.bottomRight),

            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_florist,
                  size: 80,
                  color: Color(0xFF4A6741),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Plant Analysis',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A6741),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Capture or select a plant image to analyze',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A6741),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                _buildImageButtons(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Get detailed information about your plants including care tips and disease detection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}


