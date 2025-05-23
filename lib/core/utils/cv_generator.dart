// import 'dart:convert';
// import 'dart:html' as html;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:personal_portfolio/core/themes/app_colors.dart';
// import 'package:personal_portfolio/core/themes/app_strings.dart';
// import 'package:personal_portfolio/features/experience/data/models/experience_model.dart';
// import 'package:personal_portfolio/features/portfolio/data/models/project_model.dart';

// class CVGenerator {
//   // PDF معالجة ملف ال
//   static void handleCV(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Theme.of(context).brightness == Brightness.dark
//             ? AppColors.darkCard
//             : AppColors.lightCard,
//         title: Text(
//           'Resume Options',
//           style: TextStyle(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? AppColors.textDark
//                 : AppColors.textLight,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Would you like to view or download my resume?',
//               style: TextStyle(
//                 color: Theme.of(context).brightness == Brightness.dark
//                     ? AppColors.textSecondaryDark
//                     : AppColors.textSecondaryLight,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               viewCV();
//             },
//             child: Text(
//               'View Online',
//               style: TextStyle(color: AppColors.primaryColor),
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//               downloadCV();
//             },
//             child: const Text('Download PDF'),
//           ),
//         ],
//       ),
//     );
//   }

//   // عرض ملف السيرة الذاتية في علامة تبويب جديدة
//   static void viewCV() {
//     // يمكنك استخدام رابط مباشر لعرض PDF من Google Drive
//     final pdfViewerUrl =
//         'https://drive.google.com/file/d/YOUR_FILE_ID_HERE/view?usp=sharing';
//     html.window.open(pdfViewerUrl, '_blank');
//   }

//   // تنزيل ملف السيرة الذاتية
//   static void downloadCV() {
//     // رابط التنزيل المباشر من Google Drive
//     final pdfDownloadUrl =
//         'https://drive.google.com/uc?export=download&id=YOUR_FILE_ID_HERE';
//     final anchor = html.AnchorElement(href: pdfDownloadUrl)
//       ..setAttribute('download', 'Mohamed_Abdelqawi_CV.pdf')
//       ..click();
//   }

//   // إنشاء نسخة HTML بسيطة من السيرة الذاتية كاحتياطي
//   static void _generateSimpleCV() {
//     final String htmlContent =
//         """
//     <!DOCTYPE html>
//     <html>
//     <head>
//       <meta charset="UTF-8">
//       <title>Mohamed Abdelqawi - CV</title>
//       <style>
//         body {
//           font-family: Arial, sans-serif;
//           line-height: 1.6;
//           margin: 0;
//           padding: 20px;
//           color: #333;
//         }
//         .container {
//           max-width: 800px;
//           margin: 0 auto;
//           border: 1px solid #ddd;
//           padding: 20px;
//           box-shadow: 0 0 10px rgba(0,0,0,0.1);
//         }
//         h1 {
//           color: #FD6F00;
//           margin-bottom: 5px;
//         }
//         h2 {
//           color: #FD6F00;
//           border-bottom: 2px solid #FD6F00;
//           padding-bottom: 5px;
//           margin-top: 20px;
//         }
//         .contact {
//           margin-bottom: 20px;
//         }
//         .experience, .project {
//           margin-bottom: 15px;
//         }
//         .experience h3, .project h3 {
//           margin-bottom: 5px;
//         }
//         .date-location {
//           color: #777;
//           font-style: italic;
//           margin-bottom: 10px;
//         }
//       </style>
//     </head>
//     <body>
//       <div class="container">
//         <h1>${AppStrings.name}</h1>
//         <p>${AppStrings.title}</p>
        
//         <div class="contact">
//           <p>Email: ${AppStrings.email} | Phone: ${AppStrings.phone} | Location: ${AppStrings.location}</p>
//           <p>GitHub: <a href="${AppStrings.github}">${AppStrings.github}</a> | LinkedIn: <a href="${AppStrings.linkedin}">${AppStrings.linkedin}</a></p>
//         </div>
        
//         <h2>Summary</h2>
//         <p>${AppStrings.heroDescription}</p>
        
//         <h2>Experience</h2>
//         ${_generateExperienceHTML()}
        
//         <h2>Projects</h2>
//         ${_generateProjectsHTML()}
        
//         <h2>Education</h2>
//         <div class="experience">
//           <h3>(Bachelor) of Faculty of Computers and Artificial Intelligence</h3>
//           <p class="date-location">2021 - 2025 | El Fayoum, Egypt</p>
//           <p>Department of Computer Science, Graduation year 2025 with GPA 2.7</p>
//         </div>
        
//         <h2>Skills</h2>
//         <p><strong>Programming:</strong> Dart, C++</p>
//         <p><strong>Frameworks:</strong> Flutter, Firebase</p>
//         <p><strong>State Management:</strong> Bloc/Cubit, Riverpod</p>
//         <p><strong>Tools:</strong> Git, REST APIs</p>
//         <p><strong>Architecture:</strong> Clean Architecture, MVVM</p>
//       </div>
//     </body>
//     </html>
//     """;

//     final blob = html.Blob([utf8.encode(htmlContent)], 'text/html');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute('download', 'Mohamed_Abdelqawi_CV.html')
//       ..click();

//     html.Url.revokeObjectUrl(url);
//   }

//   // Generate HTML for experiences
//   static String _generateExperienceHTML() {
//     String html = '';

//     for (var experience in ExperienceData.experiences) {
//       html +=
//           '''
//         <div class="experience">
//           <h3>${experience.role} at ${experience.company}</h3>
//           <p class="date-location">${experience.duration} | ${experience.location}</p>
//           <ul>
//       ''';

//       for (var item in experience.description) {
//         html += '<li>$item</li>';
//       }

//       html += '''
//           </ul>
//         </div>
//       ''';
//     }

//     return html;
//   }

//   // Generate HTML for projects
//   static String _generateProjectsHTML() {
//     String html = '';

//     for (var project in ProjectData.projects) {
//       html +=
//           '''
//         <div class="project">
//           <h3>${project.title}</h3>
//           <p class="date-location">${project.category} | ${project.date}</p>
//           <p>${project.description}</p>
//         </div>
//       ''';
//     }

//     return html;
//   }
// }
