// import 'package:flutter/material.dart';
//
// class ProfileController {
//   final nameController = TextEditingController(text: "Vaibhav Alone");
//   final emailController = TextEditingController(text: "t.vaibhavalone@gmail.com");
//   final phoneController = TextEditingController(text: "+91 7058405610");
//   final locationController = TextEditingController(text: "Gadchiroli, Maharashtra");
//   final linkedinController = TextEditingController(text: "linkedin.com/in/vaibhavalone");
//
//   final List<Map<String, String>> experience = [
//     {
//       'role': 'SDE-1',
//       'company': 'Insta ICT Solutions',
//       'location': 'Pune',
//       'duration': 'August 2024 - Present',
//       'description': 'Developing responsive web applications and mobile apps with focus on UI/UX design.'
//     },
//     {
//       'role': 'Java Developer',
//       'company': 'Yhills edu.',
//       'location': 'Amravati',
//       'duration': 'May 2023 - Jun 2023',
//       'description': 'Completed Java internship focusing on core Java and OOP concepts.'
//     }
//   ];
//
//   final List<Map<String, String>> projects = [
//     {
//       'name': 'Bright Weddings',
//       'tech': 'Flutter, Firebase, RestAPIs',
//       'description': 'Comprehensive matrimonial web application with profile management and matchmaking algorithms.'
//     },
//     {
//       'name': 'Banking System',
//       'tech': 'Java, JDBC, MySQL, HTML, CSS',
//       'description': 'Fully functional banking system with account handling and transaction management.'
//     }
//   ];
//
//   final List<String> skills = [
//     'Flutter',
//     'Firebase',
//     'Java',
//     'Python',
//     'MySQL',
//     'JDBC',
//     'HTML/CSS',
//     'Bootstrap',
//     'Flask',
//     'UI/UX Design',
//     'Figma',
//   ];
//
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     locationController.dispose();
//     linkedinController.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ProfileController extends ChangeNotifier {
  // Basic Info Controllers
  final nameController = TextEditingController(text: "Vaibhav Alone");
  final emailController = TextEditingController(text: "t.vaibhavalone@gmail.com");
  final phoneController = TextEditingController(text: "+91 7058405610");
  final locationController = TextEditingController(text: "Gadchiroli, Maharashtra");
  final linkedinController = TextEditingController(text: "linkedin.com/in/vaibhavalone");

  // Animation Controllers
  StateMachineController? skillsAnimationController;
  SMIInput<bool>? skillsHoverInput;

  StateMachineController? contactAnimationController;
  SMIInput<bool>? contactHoverInput;

  // Education Data
  final List<Map<String, String>> education = [
    {
      'degree': 'Bachelor of Computer Science and Engineering',
      'institution': 'P R Pote College of Engineering and Management',
      'location': 'Amravati',
      'duration': '2020 - 2024',
    },
    {
      'degree': 'State Board XII',
      'institution': 'M.G.Jr. College Desaigaj',
      'location': 'Gadchiroli',
      'duration': '2019 - 2020',
    },
  ];

  // Experience Data
  final List<Map<String, String>> experience = [
    {
      'role': 'SDE-1',
      'company': 'Insta ICT Solutions',
      'location': 'Pune',
      'duration': 'August 2024 - Present',
      'description': 'Developing responsive web applications and mobile apps. Designed UI interfaces for enhanced user interaction. Collaborated with back-end teams on RESTful APIs integration.',
      'icon': 'assets/company_icon.riv'
    },
    {
      'role': 'Java Developer',
      'company': 'Yhills edu.',
      'location': 'Amravati',
      'duration': 'May 2023 - Jun 2023',
      'description': 'Completed Java internship with focus on core Java and OOP concepts. Worked on real projects improving problem-solving skills.',
      'icon': 'assets/java_icon.riv'
    }
  ];

  // Projects with enhanced details
  final List<Map<String, dynamic>> projects = [
    {
      'name': 'Bright Weddings',
      'tech': 'Flutter, Firebase, RestAPIs',
      'description': 'Comprehensive matrimonial web application with profile management and matchmaking algorithms.',
      'features': [
        'User profile management',
        'Advanced matchmaking algorithms',
        'Secure data storage',
        'Responsive design',
      ],
      'icon': 'assets/wedding_icon.riv',
    },
    {
      'name': 'Banking System',
      'tech': 'Java, JDBC, MySQL, HTML, CSS',
      'description': 'Fully functional banking system with account handling and transaction management.',
      'features': [
        'Account management',
        'Transaction processing',
        'Balance tracking',
        'Secure authentication',
      ],
      'icon': 'assets/bank_icon.riv',
    }
  ];

  // Skills with categories
  final Map<String, List<String>> skillsByCategory = {
    'Frontend': ['Flutter', 'HTML/CSS', 'UI/UX Design', 'Figma'],
    'Backend': ['Java', 'Python', 'MySQL', 'JDBC'],
    'Tools & Technologies': ['Firebase', 'Bootstrap', 'Flask', 'Git/GitHub'],
  };

  // Certifications
  final List<Map<String, String>> certifications = [
    {
      'name': 'Java Programming with OOPs concept',
      'provider': 'Coursera',
      'date': '2023'
    },
    {
      'name': 'Programming Foundations with JavaScript, HTML and CSS',
      'provider': 'Coursera',
      'date': '2023'
    }
  ];

  // Animation state management
  void initSkillsAnimation(StateMachineController controller) {
    skillsAnimationController = controller;
    skillsHoverInput = controller.findInput('hover');
  }

  void initContactAnimation(StateMachineController controller) {
    contactAnimationController = controller;
    contactHoverInput = controller.findInput('hover');
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    linkedinController.dispose();
    skillsAnimationController?.dispose();
    contactAnimationController?.dispose();
  }
}