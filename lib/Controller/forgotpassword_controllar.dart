import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordControllar extends GetxController{

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


}