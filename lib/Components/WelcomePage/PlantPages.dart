// plant_info_screen.dart
import 'package:flutter/material.dart';
import 'package:triyaa_com/Components/WelcomePage/global_page.dart';
import 'dart:ui' as ui;

import 'package:triyaa_com/Controller/welcome_page_controllar.dart';

class PlantInfoScreen extends StatefulWidget {
  const PlantInfoScreen({Key? key}) : super(key: key);

  @override
  _PlantInfoScreenState createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> with TickerProviderStateMixin {

  PlantInfoController _controller = new PlantInfoController();

  @override
  void initState() {
    super.initState();
    _controller = PlantInfoController();
    _controller.initializeAnimations(this);
    _controller.startAnimations();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F2),
      body: Stack(
        children: [
          _buildBackgroundDecorations(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildMainContent(),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Animated circles
        ...List.generate(3, (index) {
          return Positioned(
            top: -50.0 + (index * 30),
            right: -50.0 + (index * 20),
            child: AnimatedBuilder(
              animation: _controller.rotateAnimation!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.rotateAnimation!.value + (index * 0.5),
                  child: Container(
                    width: 150 - (index * 20),
                    height: 150 - (index * 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0EED5).withOpacity(0.3 - (index * 0.1)),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          );
        }),

        // Leaf patterns
        Positioned(
          bottom: 0,
          left: 0,
          child: CustomPaint(
            size: const Size(100, 100),
            painter: LeafPatternPainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        FadeTransition(
          opacity: _controller.fadeAnimation!,
          child: SlideTransition(
            position: _controller.slideAnimation!,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A6741), Color(0xFF2D3A24)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A6741).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.eco, color: Colors.white, size: 20), // Replacing image with icon
                  SizedBox(width: 8),
                  Text(
                    "Plant Guide",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            ScaleTransition(
              scale: _controller.scaleAnimation!,
              child: const Text(
                "Discover the Joy\nof Plant Parenting",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3A24),
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildTipsCard(),
            const SizedBox(height: 24),
            _buildImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return FadeTransition(
      opacity: _controller.fadeAnimation!,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Essential Care Tips",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A6741),
              ),
            ),
            const SizedBox(height: 16),
            ..._controller.plantTips.map((tip) => _buildAnimatedTipItem(tip)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTipItem(PlantTip tip) {
    return SlideTransition(
      position: _controller.slideAnimation!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F9F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4A6741).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(tip.icon, color: const Color(0xFF4A6741), size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3A24),
                    ),
                  ),
                  Text(
                    tip.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF2D3A24).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              'https://images.pexels.com/photos/1048036/pexels-photo-1048036.jpeg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Learn More",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Swipe to explore plant care guides",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GlobalPage()),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A6741),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 20),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(value, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 20, end: 40),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(value, 0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: _controller.skipTutorial,
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A6741),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeafPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A6741).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    // Draw decorative leaf pattern
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.7,
      size.width,
      size.height,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}