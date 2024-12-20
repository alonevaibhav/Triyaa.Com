import 'package:flutter/material.dart';
import 'package:triyaa_com/Components/WelcomePage/PlantPages.dart';
import 'package:triyaa_com/Components/WelcomePage/main_page.dart';
import 'package:triyaa_com/Helper/buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF8CAF7A), // Background green color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Save the Planet Text
              const Column(
                children: [
                  Icon(
                    Icons.spa, // Leaf-like icon
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Share\nTHE\nPLANT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              // Start Button
              CustomButton(
                text: 'Press Me',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  // Navigate to SendPage when button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageSlider(), // Replace with the actual page you're navigating to
                    ),
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


