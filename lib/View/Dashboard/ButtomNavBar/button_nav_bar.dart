import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Components/%20bottom_navigation/bottomNav.dart';
import 'package:triyaa_com/Controller/navigation_controller.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/plant_detection_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex,
        children: [
          const Center(child: Text('Garden View')),
          Center(child:PlantDetectionScreen()),
          const Center(child: Text('Plant List')),
        ],

      )),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
