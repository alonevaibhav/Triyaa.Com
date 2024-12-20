
import 'package:flutter/material.dart';
import 'package:triyaa_com/Components/WelcomePage/PlantPages.dart';
import 'package:triyaa_com/Components/WelcomePage/global_page.dart';
import 'package:triyaa_com/View/WelcomePage/welcome_page.dart';

class PageSlider extends StatelessWidget {
  final List<Widget> pages = [
    PlantInfoScreen(),
    GlobalPage(), // Replace with your next screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: pages,
        physics: BouncingScrollPhysics(), // Smooth bouncing effect
      ),
    );
  }
}