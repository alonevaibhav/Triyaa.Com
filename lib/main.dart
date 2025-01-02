import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Helper/colors.dart';
import 'package:triyaa_com/View/Dashboard/ButtomNavBar/button_nav_bar.dart';
import 'package:triyaa_com/View/WelcomePage/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Triyaa',
      theme: ThemeData(
        primaryColor: primaryColor,
        hintColor: hintColor,
        colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
      ),
      home: HomeScreen(),
      // HomeScreen(),
    );
  }
}
