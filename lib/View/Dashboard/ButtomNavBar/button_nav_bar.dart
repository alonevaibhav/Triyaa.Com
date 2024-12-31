import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Components/%20bottom_navigation/bottomNav.dart';
import 'package:triyaa_com/Controller/navigation_controller.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/middle_buttton.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/plant_detection_page.dart';
import 'package:triyaa_com/View/Dashboard/NavButtons/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NavigationController controller = Get.put(NavigationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex,
        children: [
          Center(child: MiddleButton()),
          Center(child: PlantDetectionScreen()),
          Center(child: ProfilePage()),
        ],
      )),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
