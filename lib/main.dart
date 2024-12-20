import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:triyaa_com/Helper/colors.dart';
import 'package:triyaa_com/Helper/colors.dart';
import 'package:triyaa_com/Helper/colors.dart';

import 'package:triyaa_com/View/WelcomePage/welcome_page.dart'; // Import WelcomePage

void main() {
  // Initialize GetX dependency
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Use GetMaterialApp for GetX integration
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Triyaa',
      theme: ThemeData(
        primaryColor: primaryColor, // Set primary color
        hintColor: hintColor,  // Accent color for buttons and others
        colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
        // UseMaterial3: true, // Uncomment if Material 3 design is required
      ),
      home: WelcomePage(),
    );
  }
}


