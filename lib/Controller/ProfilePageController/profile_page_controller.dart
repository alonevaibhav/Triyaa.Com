import 'package:flutter/material.dart';

class ProfileController {
  final nameController = TextEditingController(text: "Vaibhav Alone");
  final emailController = TextEditingController(text: "t.vaibhavalone@gmail.com");
  final phoneController = TextEditingController(text: "+91 7058405610");
  final locationController = TextEditingController(text: "Gadchiroli, Maharashtra");
  final linkedinController = TextEditingController(text: "linkedin.com/in/vaibhavalone");

  final List<Map<String, String>> experience = [
    {
      'role': 'SDE-1',
      'company': 'Insta ICT Solutions',
      'location': 'Pune',
      'duration': 'August 2024 - Present',
      'description': 'Developing responsive web applications and mobile apps with focus on UI/UX design.'
    },
    {
      'role': 'Java Developer',
      'company': 'Yhills edu.',
      'location': 'Amravati',
      'duration': 'May 2023 - Jun 2023',
      'description': 'Completed Java internship focusing on core Java and OOP concepts.'
    }
  ];

  final List<Map<String, String>> projects = [
    {
      'name': 'Bright Weddings',
      'tech': 'Flutter, Firebase, RestAPIs',
      'description': 'Comprehensive matrimonial web application with profile management and matchmaking algorithms.'
    },
    {
      'name': 'Banking System',
      'tech': 'Java, JDBC, MySQL, HTML, CSS',
      'description': 'Fully functional banking system with account handling and transaction management.'
    }
  ];

  final List<String> skills = [
    'Flutter',
    'Firebase',
    'Java',
    'Python',
    'MySQL',
    'JDBC',
    'HTML/CSS',
    'Bootstrap',
    'Flask',
    'UI/UX Design',
    'Figma',
  ];

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    linkedinController.dispose();
  }
}