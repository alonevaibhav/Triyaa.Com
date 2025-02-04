import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:triyaa_com/Constants/endpoints.dart';
import 'package:triyaa_com/Model/signup_model.dart';
import 'package:triyaa_com/View/Auth/login_page.dart';

class SignUpPage extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isLoading = false.obs; // Observable for loading state

  // Method to handle signup
  Future<void> signUp() async {
    try {
      isLoading(true); // Start loading

      // Create a SignUpModel instance
      final signUpData = SignUpModel(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Make the API call
      final response = await http.post(
        Uri.parse(signInUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(signUpData.toJson()),
      );
      print(response.body);
      print(response.statusCode);


      // Check the response status
      if (response.statusCode == 200||response.statusCode == 201) {
        // Success
        final responseData = json.decode(response.body);
        Get.snackbar('Success', 'User created successfully!');
        print('User created: ${responseData['user']}');
        Get.to(LoginPage());
      } else {
        // Error
        final errorData = json.decode(response.body);
        Get.snackbar('Error', errorData['error'] ?? 'Something went wrong');
      }
    } catch (e) {
      // Handle exceptions
      print(e);
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }




  // Method to reset the form fields
  void resetForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
