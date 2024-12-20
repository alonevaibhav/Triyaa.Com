// plant_info_controller.dart
import 'package:flutter/material.dart';

class PlantInfoController with ChangeNotifier {
  // Animation controllers
  AnimationController? fadeController;
  AnimationController? slideController;
  AnimationController? scaleController;

  // Animations
  Animation<double>? fadeAnimation;
  Animation<Offset>? slideAnimation;
  Animation<double>? scaleAnimation;
  Animation<double>? rotateAnimation;

  int currentPage = 0;
  final int totalPages = 3;

  final List<PlantTip> plantTips = [
    PlantTip(
      icon: Icons.water_drop_outlined,
      title: 'Water Care',
      description: 'Check soil moisture before watering',
    ),
    PlantTip(
      icon: Icons.wb_sunny_outlined,
      title: 'Sunlight',
      description: 'Place in bright, indirect sunlight',
    ),
    PlantTip(
      icon: Icons.thermostat_outlined,
      title: 'Temperature',
      description: 'Maintain between 65-80°F (18-27°C)',
    ),
    PlantTip(
      icon: Icons.science_outlined,
      title: 'Soil Type',
      description: 'Use well-draining potting mix',
    ),
  ];

  void initializeAnimations(TickerProvider vsync) {
    fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync,
    );

    slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: vsync,
    );

    scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: vsync,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController!, curve: Curves.easeIn),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideController!,
      curve: Curves.elasticOut,
    ));

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: scaleController!, curve: Curves.easeOutBack),
    );

    rotateAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: scaleController!, curve: Curves.easeInOutBack),
    );
  }

  void startAnimations() {
    fadeController?.forward();
    slideController?.forward();
    scaleController?.forward();
  }

  void nextPage() {
    if (currentPage < totalPages - 1) {
      currentPage++;
      notifyListeners();
    }
  }

  void skipTutorial() {
    currentPage = totalPages - 1;
    notifyListeners();
  }

  @override
  void dispose() {
    fadeController?.dispose();
    slideController?.dispose();
    scaleController?.dispose();
    super.dispose();
  }
}

class PlantTip {
  final IconData icon;
  final String title;
  final String description;

  PlantTip({
    required this.icon,
    required this.title,
    required this.description,
  });
}