import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../../../core/themes/app_colors.dart';

class HireMeHandler {
  // التمرير إلى قسم الاتصال
  static void scrollToContact(
    BuildContext context,
    ScrollController scrollController,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    // تحديد موقع قسم الاتصال (اعتماداً على ترتيب الأقسام في الصفحة)
    // قد تحتاج لتعديل هذه القيمة بناءً على هيكل الصفحة
    final contactSectionIndex = 6; // افتراض أن Contact هو القسم السابع

    // التمرير إلى قسم الاتصال
    scrollController.animateTo(
      contactSectionIndex * screenHeight,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  // إرسال رسالة واتساب
  static void sendWhatsAppMessage(
    String phone,
    String message, {
    BuildContext? context,
  }) async {
    try {
      // تنظيف رقم الهاتف وإزالة أي رموز غير رقمية
      final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

      // تشفير الرسالة للاستخدام في URL
      final encodedMessage = Uri.encodeComponent(message);

      // إنشاء رابط WhatsApp
      final whatsappUrl = 'https://wa.me/$cleanPhone?text=$encodedMessage';

      // فتح رابط WhatsApp
      final uri = Uri.parse(whatsappUrl);
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(
          uri,
          mode: url_launcher.LaunchMode.externalApplication,
        );
      } else if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open WhatsApp. Please install WhatsApp or try again later.',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error sending WhatsApp message: $e');
      if (context != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  // إرسال بريد إلكتروني
  static void sendEmail(
    String email,
    String subject,
    String body, {
    BuildContext? context,
  }) async {
    try {
      // تشفير الموضوع والرسالة للاستخدام في URL
      final encodedSubject = Uri.encodeComponent(subject);
      final encodedBody = Uri.encodeComponent(body);

      // إنشاء رابط البريد الإلكتروني
      final emailUrl =
          'mailto:$email?subject=$encodedSubject&body=$encodedBody';

      // فتح تطبيق البريد الإلكتروني
      final uri = Uri.parse(emailUrl);
      if (await url_launcher.canLaunchUrl(uri)) {
        await url_launcher.launchUrl(uri);
      } else if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open email app. Please try again later.'),
          ),
        );
      }
    } catch (e) {
      print('Error sending email: $e');
      if (context != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  // عرض نموذج اتصال في مربع حوار
  static void showHireMeDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final messageController = TextEditingController();
    final serviceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : AppColors.lightCard,
        title: Text(
          'Let\'s Work Together',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Your Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Your Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: serviceController,
                    decoration: InputDecoration(
                      labelText: 'Service Required',
                      prefixIcon: Icon(Icons.work),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the service you need';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      prefixIcon: Icon(Icons.message),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final whatsappMessage =
                    '''
                اسمي ${nameController.text.trim()}

                معلومات التواصل:
                - الاسم: ${nameController.text.trim()}
                - الايميل: ${emailController.text.trim()}
                - الموضوع: ${serviceController.text.trim()}

                نص الرسالة:
                ${messageController.text.trim()}

                في انتظار ردكم
                شكرا لكم ✨
                ''';

                final emailBody =
                    '''
                الاسم: ${nameController.text.trim()}
                البريد الالكتروني: ${emailController.text.trim()}
                الموضوع: ${serviceController.text.trim()}

                الرسالة:
                ${messageController.text.trim()}

                تحياتي،
                Mohamed Abd ElQawi
                ''';

                // عرض خيارات الإرسال
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Choose Sending Method'),
                    content: Text('How would you like to send your message?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          sendWhatsAppMessage(
                            '+201060796400',
                            whatsappMessage,
                            context: context,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message sent via WhatsApp!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text('WhatsApp'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          sendEmail(
                            'mohamedahbd545@gmail.com',
                            'Portfolio Inquiry from ${nameController.text}',
                            emailBody,
                            context: context,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message sent via Email!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        child: Text('Email'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
