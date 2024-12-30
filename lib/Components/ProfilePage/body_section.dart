//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:glassmorphism/glassmorphism.dart';
// import 'package:triyaa_com/Controller/ProfilePageController/profile_page_controller.dart';
//
// class BodySection extends StatelessWidget {
//   const BodySection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:  _buildBody(),
//     );
//   }
// }
//
// ProfileController controller = new ProfileController();
//
// Widget _buildBody() {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.7), // Set opacity to 50%
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//     ),
//     child: Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         children: [
//           _buildContactInfo(),
//           SizedBox(height: 30),
//           _buildExperienceSection(),
//           SizedBox(height: 30),
//           _buildProjectsSection(),
//           SizedBox(height: 30),
//           _buildSkillsSection(),
//         ],
//       ),
//     ),
//   );
// }
//
//
// Widget _buildContactInfo() {
//   return GlassmorphicContainer(
//     width: double.infinity,
//     height: 200,
//     borderRadius: 20,
//     blur: 20,
//     alignment: Alignment.center,
//     border: 2,
//     linearGradient: LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         Color(0xFF4A6741).withOpacity(0.1),
//         Color(0xFF4A6741).withOpacity(0.05),
//       ],
//     ),
//     borderGradient: LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         Color(0xFF4A6741).withOpacity(0.5),
//         Color(0xFF4A6741).withOpacity(0.2),
//       ],
//     ),
//     child: Padding(
//       padding: EdgeInsets.all(20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildContactRow(FontAwesomeIcons.envelope, controller.emailController.text),
//           _buildContactRow(FontAwesomeIcons.phone, controller.phoneController.text),
//           _buildContactRow(FontAwesomeIcons.locationDot, controller.locationController.text),
//           _buildContactRow(FontAwesomeIcons.linkedin, controller.linkedinController.text),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _buildContactRow(IconData icon, String text) {
//   return Row(
//     children: [
//       Container(
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Color(0xFF4A6741),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 5,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: Colors.white, size: 20),
//       ),
//       SizedBox(width: 15),
//       Expanded(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF4A6741),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     ],
//   );
// }
//
// Widget _buildExperienceSection() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Experience",
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF2D3A24),
//         ),
//       ),
//       const SizedBox(height: 16),
//       ...controller.experience.map((exp) => _buildExperienceCard(exp)),
//     ],
//   );
// }
//
// Widget _buildExperienceCard(Map<String, String> exp) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 16),
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 10,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           exp['role']!,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF4A6741),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           "${exp['company']} - ${exp['location']}",
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black.withOpacity(0.8),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           exp['duration']!,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.6),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           exp['description']!,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.7),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildProjectsSection() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Projects",
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF2D3A24),
//         ),
//       ),
//       const SizedBox(height: 16),
//       ...controller.projects.map((project) => _buildProjectCard(project)),
//     ],
//   );
// }
//
// Widget _buildProjectCard(Map<String, String> project) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 16),
//     padding: const EdgeInsets.all(16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 10,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           project['name']!,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF4A6741),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           project['tech']!,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.6),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           project['description']!,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.7),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildSkillsSection() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Skills",
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Color(0xFF2D3A24),
//         ),
//       ),
//       const SizedBox(height: 16),
//       Wrap(
//         spacing: 8,
//         runSpacing: 8,
//         children: controller.skills.map((skill) => _buildSkillChip(skill)).toList(),
//       ),
//     ],
//   );
// }
//
// Widget _buildSkillChip(String skill) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     decoration: BoxDecoration(
//       color: const Color(0xFF4A6741).withOpacity(0.1),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(
//         color: const Color(0xFF4A6741).withOpacity(0.3),
//       ),
//     ),
//     child: Text(
//       skill,
//       style: const TextStyle(
//         color: Color(0xFF4A6741),
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//   );
// }
//
//


import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:triyaa_com/Controller/ProfilePageController/profile_page_controller.dart';
import 'package:flutter/painting.dart' as flutter_paint;


class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
   ProfileController controller =new ProfileController();

   @override
   void initState() {
     super.initState();
     controller = ProfileController();
   }

   @override
   void dispose() {
     controller.dispose();
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: flutter_paint.LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A6741).withOpacity(0.1),
              Colors.white.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          // Background Rive animation
          RiveAnimation.asset(
            'assets/background_shapes.riv',
            fit: BoxFit.cover,
          ),
          // Profile content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF4A6741),
                  child: Text(
                    controller.nameController.text.substring(0, 2).toUpperCase(),
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  controller.nameController.text,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3A24),
                  ),
                ),
                Text(
                  "Software Developer",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4A6741),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildContactInfo(),
            SizedBox(height: 30),
            _buildExperienceSection(),
            SizedBox(height: 30),
            _buildProjectsSection(),
            SizedBox(height: 30),
            _buildSkillsSection(),
            SizedBox(height: 30),
            // _buildEducationSection(),
          ],
        ),
      ),
    );
  }

   Widget _buildContactInfo() {
     return GlassmorphicContainer(
       width: double.infinity,
       height: 200,
       borderRadius: 20,
       blur: 20,
       alignment: Alignment.center,
       border: 2,
       linearGradient: flutter_paint.LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: [
           Color(0xFF4A6741).withOpacity(0.1),
           Color(0xFF4A6741).withOpacity(0.05),
         ],
       ),
       borderGradient: flutter_paint.LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: [
           Color(0xFF4A6741).withOpacity(0.5),
           Color(0xFF4A6741).withOpacity(0.2),
         ],
       ),
       child: Stack(
         children: [
           // Contact info Rive animation
           RiveAnimation.asset(
             'assets/contact_background.riv',
             onInit: (artboard) {
               final controller = StateMachineController.fromArtboard(
                   artboard,
                   'contact_machine' // Make sure this matches your Rive file's state machine name
               );
               if (controller != null) {
                 artboard.addController(controller);
                 this.controller.initContactAnimation(controller);
               }
             },
           ),
           // Contact details
           Padding(
             padding: EdgeInsets.all(20),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 _buildContactRow(FontAwesomeIcons.envelope, controller.emailController.text),
                 _buildContactRow(FontAwesomeIcons.phone, controller.phoneController.text),
                 _buildContactRow(FontAwesomeIcons.locationDot, controller.locationController.text),
                 _buildContactRow(FontAwesomeIcons.linkedin, controller.linkedinController.text),
               ],
             ),
           ),
         ],
       ),
     );
   }

  Widget _buildContactRow(IconData icon, String text) {
    return MouseRegion(
      onEnter: (_) => controller.contactHoverInput?.change(true),
      onExit: (_) => controller.contactHoverInput?.change(false),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF4A6741),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A6741),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 15),

          ],
        ),
      ),
    );
  }

Widget _buildExperienceSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Experience",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3A24),
        ),
      ),
      const SizedBox(height: 16),
      ...controller.experience.map((exp) => _buildExperienceCard(exp)),
    ],
  );
}

Widget _buildExperienceCard(Map<String, String> exp) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exp['role']!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A6741),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${exp['company']} - ${exp['location']}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          exp['duration']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exp['description']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProjectsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Projects",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3A24),
        ),
      ),
      const SizedBox(height: 16),
      ...controller.projects.map((project) => _buildProjectCard(project)),
    ],
  );
}

Widget _buildProjectCard(Map<String, dynamic> project) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project['name']!,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A6741),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project['tech']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project['description']!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildSkillsSection() {
    List<String> allSkills = controller.skillsByCategory.values.expand((skills) => skills).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Skills",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3A24),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allSkills.map((skill) => _buildSkillChip(skill)).toList(),
        ),
      ],
    );
  }

Widget _buildSkillChip(String skill) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFF4A6741).withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF4A6741).withOpacity(0.3),
      ),
    ),
    child: Text(
      skill,
      style: const TextStyle(
        color: Color(0xFF4A6741),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
}
