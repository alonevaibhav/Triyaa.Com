import 'package:flutter/material.dart';
import 'package:triyaa_com/Controller/login_page_Controllar.dart';
import 'package:triyaa_com/View/Auth/forgot_password.dart';
import 'dart:math' as math;
import 'package:triyaa_com/View/Auth/sign_up_page.dart';
import 'package:triyaa_com/View/Dashboard/ButtomNavBar/button_nav_bar.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  late AnimationController _controller;
  late Animation<double> _leafAnimation;

  LoginControllar controller = new LoginControllar();


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _leafAnimation = Tween<double>(
      begin: 0,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }
  @override
  void dispose() {
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F2),
      body: Stack(
        children: [
          _buildBackgroundDecoration(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildLoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundDecoration() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: AnimatedBuilder(
            animation: _leafAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: math.pi * _leafAnimation.value,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A6741).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 100,
          right: -50,
          child: AnimatedBuilder(
            animation: _leafAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: -math.pi * _leafAnimation.value,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A6741).withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
        // Add decorative leaves
        Positioned(
          bottom: 50,
          left: -20,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Icon(
              Icons.eco,
              size: 100,
              color: const Color(0xFF4A6741).withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4A6741),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.eco, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "PlantCare",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Welcome Back\nPlant Parent!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3A24),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Login to continue your plant care journey",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildCustomTextField(
            controller: controller.emailController,
            labelText: "Email",
            prefixIcon: Icons.email_outlined,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildCustomTextField(
            controller: controller.passwordController,
            labelText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF4A6741),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildRememberMeAndForgotPassword(),
          const SizedBox(height: 24),
          _buildLoginButton(),
          const SizedBox(height: 24),
          _buildSocialLogin(),
          const SizedBox(height: 24),
          _buildSignUpLink(),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
          prefixIcon: Icon(prefixIcon, color: const Color(0xFF4A6741)),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
                activeColor: const Color(0xFF4A6741),
              ),
            ),
            const SizedBox(width: 8),
            const Text("Remember me"),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
            );
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xFF4A6741),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Handle login (e.g., authentication logic)

            // Navigate to HomeScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A6741),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Text(
          "Or continue with",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(Icons.g_mobiledata, "Google"),
            const SizedBox(width: 16),
            _buildSocialButton(Icons.apple, "Apple"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String platform) {
    return Container(
      width: 150,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextButton.icon(
        onPressed: () {
          // Handle social login
        },
        icon: Icon(icon, color: Colors.black),
        label: Text(platform),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlantSignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFF4A6741),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}