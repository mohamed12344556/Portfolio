import 'package:flutter/material.dart';
import 'package:personal_portfolio/core/themes/app_colors.dart';
import 'package:personal_portfolio/core/themes/app_strings.dart';
import 'package:personal_portfolio/core/widgets/animated_button.dart';
import 'package:personal_portfolio/features/contact/presentation/widgets/hire_me_handler.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  String? _submitMessage;
  bool _submitSuccess = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _submitMessage = null;
      });

      // بناء الرسالة
      final message =
          '''
              Name: ${_nameController.text}
              Email: ${_emailController.text}
              Subject: ${_subjectController.text}
              Message: ${_messageController.text}
      ''';

      // محاولة إرسال الرسالة عبر الواتساب
      try {
        HireMeHandler.sendWhatsAppMessage('+201060796400', message);
      } catch (e) {
        print("Error sending WhatsApp: $e");
      }

      // محاولة إرسال بريد إلكتروني
      try {
        HireMeHandler.sendEmail(
          'mohamedahbd545@gmail.com',
          'Contact Form: ${_subjectController.text}',
          message,
        );
      } catch (e) {
        print("Error sending email: $e");
      }

      // إظهار رسالة نجاح
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isSubmitting = false;
          _submitSuccess = true;
          _submitMessage =
              'Thank you for your message! I will get back to you soon.';
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextFormField(
                  controller: _nameController,
                  hintText: 'Your Name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildTextFormField(
                  controller: _emailController,
                  hintText: 'Your Email',
                  prefixIcon: Icons.email,
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
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            controller: _subjectController,
            hintText: 'Subject',
            prefixIcon: Icons.subject,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            controller: _messageController,
            hintText: 'Your Message',
            prefixIcon: Icons.message,
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          if (_submitMessage != null)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: _submitSuccess
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _submitSuccess ? Colors.green : Colors.red,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _submitSuccess ? Icons.check_circle : Icons.error,
                    color: _submitSuccess ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _submitMessage!,
                      style: TextStyle(
                        color: _submitSuccess ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_submitMessage != null) const SizedBox(height: 20),
          Center(
            child: AnimatedButton(
              text: _isSubmitting ? 'Sending...' : AppStrings.sendMessage,
              onPressed: _isSubmitting ? () {} : _submitForm,
              isPrimary: true,
              icon: Icons.send,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: isDark ? AppColors.darkCard : AppColors.lightCard,
      ),
      style: TextStyle(
        color: isDark ? AppColors.textDark : AppColors.textLight,
      ),
      maxLines: maxLines,
      validator: validator,
    );
  }
}
