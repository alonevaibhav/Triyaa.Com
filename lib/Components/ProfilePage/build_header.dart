import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:math' as math;

class BuildHeader extends StatefulWidget {
  BuildHeader({Key? key}) : super(key: key);

  @override
  State<BuildHeader> createState() => _BuildHeaderState();
}

class _BuildHeaderState extends State<BuildHeader> with TickerProviderStateMixin {
  final math.Random random = math.Random();
  int currentIndex = 0;
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg', // Add your network image URLs here
    'https://sm.askmen.com/t/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_fr3n.1200.jpg',
    'https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp',
    'https://images.pexels.com/photos/7087169/pexels-photo-7087169.jpeg',
  ];

  late AnimationController _photoAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animations
    _photoAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Position animation
    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(random.nextBool() ? 1.0 : -1.0, random.nextBool() ? 1.0 : -1.0),
    ).animate(CurvedAnimation(
      parent: _photoAnimation,
      curve: Curves.easeInOut,
    ));

    // Shake animation
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _photoAnimation,
      curve: Curves.elasticOut,
    ));

    _photoAnimation.addListener(() {
      setState(() {});
    });

    _photoAnimation.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated background circles
          Positioned(
            top: -100,
            right: -100,
            child: AnimatedBuilder(
              animation: _photoAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.9 + 0.5 * math.sin(_photoAnimation.value * math.pi),
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Network image in a circular shape with slide-in animation
          Positioned(
            top: _positionAnimation.value.dy * 50 + 50,
            left: _positionAnimation.value.dx * 50 + 50,
            right: _positionAnimation.value.dy * 50 + 50,
            bottom: _positionAnimation.value.dx * 50 + 50,
            child: Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: GestureDetector(
                onTap: () {
                  _photoAnimation.reset(); // Reset animation on tap
                  setState(() {
                    currentIndex = (currentIndex + 1) % imageUrls.length; // Change index
                  });
                },
                child: ClipOval(
                  child: Container(
                    width: 240,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 25,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.network(
                      imageUrls[currentIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Name and Title
          Positioned(
            bottom: 50,
            child: GlassmorphicContainer(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              borderRadius: 20,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.2),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flutter Developer',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'UI/UX Designer',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _photoAnimation.dispose();
    super.dispose();
  }
}
