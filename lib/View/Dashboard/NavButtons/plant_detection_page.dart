
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triyaa_com/Controller/plant_controllar.dart';

class PlantDetectionScreen extends StatefulWidget {
  PlantDetectionScreen({Key? key}) : super(key: key);

  @override
  State<PlantDetectionScreen> createState() => _PlantDetectionScreenState();
}

class _PlantDetectionScreenState extends State<PlantDetectionScreen> {
  PlantDetectionController controller = Get.put(PlantDetectionController());
  // Initialize controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F2),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 20),
                  _buildImageButtons(),
                  const SizedBox(height: 20),
                  _buildSampleImages(),
                  const SizedBox(height: 20),
                  _buildPlantInfo(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFF4A6741),
            child: Icon(Icons.eco, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Identify Plants Instantly',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Take or upload a photo to get started',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Detections',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage('assets/plant_${index + 1}.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF4A6741),
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Triyaa Plant Detection'),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.pexels.com/photos/305821/pexels-photo-305821.jpeg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF4A6741).withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            'Open Gallery',
            Icons.photo_library,
                () => controller.pickImageAndDetectPlant(ImageSource.gallery),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            'Take Photo',
            Icons.camera_alt,
                () => controller.pickImageAndDetectPlant(ImageSource.camera),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
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

  Widget _buildPlantInfo() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final selectedImage = controller.selectedImage.value;
      if (selectedImage == null) {
        return const SizedBox.shrink();
      }

      return FutureBuilder<Map<String, dynamic>>(
        future: controller.plantDetectionAPI.fetchPlantInfo(selectedImage.path),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final plantData = snapshot.data!;
          return _buildPlantDetailsCard(plantData);
        },
      );
    });
  }

  Widget _buildPlantDetailsCard(Map<String, dynamic> plantData) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.file(
                File(controller.selectedImage.value!.path),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            _buildPlantDataSection(
              title: plantData['name'] ?? 'Unknown Plant',
              scientific: plantData['scientific'],
              englishName: plantData['englishName'],
              marathiName: plantData['marathiName'],
              hindiName: plantData['hindiName'],
              care: plantData['care'],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantDataSection({
    required String title,
    String? scientific,
    String? englishName,
    String? marathiName,
    String? hindiName,
    String? care,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (scientific != null) ...[
          const SizedBox(height: 4),
          Text(
            'Scientific Name: $scientific',
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
        if (englishName != null) ...[
          const SizedBox(height: 4),
          Text(
            'English Name: $englishName',
            style: const TextStyle(fontSize: 16),
          ),
        ],
        if (marathiName != null) ...[
          const SizedBox(height: 4),
          Text(
            'Marathi Name: $marathiName',
            style: const TextStyle(fontSize: 16),
          ),
        ],
        if (hindiName != null) ...[
          const SizedBox(height: 4),
          Text(
            'Hindi Name: $hindiName',
            style: const TextStyle(fontSize: 16),
          ),
        ],
        if (care != null) ...[
          const SizedBox(height: 12),
          const Text(
            'Care Instructions:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            care,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ],
    );
  }
}