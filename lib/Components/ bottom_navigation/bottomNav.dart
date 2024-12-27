// lib/views/widgets/custom_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Controller/navigation_controller.dart';

class CustomBottomNav extends GetView<NavigationController> {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.forest, "Garden"),
                const SizedBox(width: 60), // Space for center button
                _buildNavItem(2, Icons.person_off_outlined, "Plants"),
              ],
            ),
          ),
          Positioned(
            top: 3,
            left: 0,
            right: 0,
            child: _buildCenterButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    return Obx(() => GestureDetector(
      onTap: () => controller.changePage(index),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: controller.selectedIndex == index
                  ? const Color(0xFF4A6741)
                  : Colors.grey,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.selectedIndex == index
                    ? const Color(0xFF4A6741)
                    : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => controller.changePage(1),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF4A6741),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Obx(() => Icon(
          Icons.local_florist,
          color: controller.selectedIndex == 1
              ? Colors.white
              : Colors.white.withOpacity(0.8),
          size: 32,
        )),
      ),
    );
  }
}