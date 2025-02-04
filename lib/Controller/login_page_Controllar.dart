import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triyaa_com/Constants/endpoints.dart';
import 'package:triyaa_com/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:triyaa_com/View/Dashboard/ButtomNavBar/button_nav_bar.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isLoading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void erase() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> logIn() async {
    try {
      isLoading(true); // Start loading

      final loginData = LoginModel(
        email: emailController.text,
        password: passwordController.text,
      );

      final response = await http.post(
        Uri.parse(LoginInUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData.toJson()),
      );

      print("Response Body: ${response.body}");
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        final responseData = json.decode(response.body);
        Get.snackbar('Success', 'Login successful!');
        Get.offAll(() => HomeScreen()); // Navigate to HomeScreen
      } else {
        // Error
        final errorData = json.decode(response.body);
        final errorMessage =
            errorData['message'] ?? 'Invalid email or password';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      // Handle exceptions
      print("Error: $e");
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
