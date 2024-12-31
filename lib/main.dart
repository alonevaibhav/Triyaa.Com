import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Helper/colors.dart';
import 'package:triyaa_com/View/Dashboard/ButtomNavBar/button_nav_bar.dart';
import 'package:triyaa_com/View/WelcomePage/welcome_page.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestLocationPermission(); // Request location permission at app start
  runApp(const MyApp());
}

Future<void> requestLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, request user to enable them
    throw Exception('Location services are disabled.');
  }

  // Check and request location permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission denied, return
      throw Exception('Location permission denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever
    throw Exception('Location permissions are permanently denied.');
  }
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
      home:
      WelcomePage(),
      // HomeScreen(),
    );
  }
}
