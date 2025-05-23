import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as url_launcher;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncher {
  // إطلاق رابط URL مع معالجة الأخطاء
  static Future<void> launchURL(String url, {BuildContext? context}) async {
    try {
      // التأكد من أن الرابط يبدأ بـ http:// أو https://
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      // تحويل النص إلى URI
      final Uri uri = Uri.parse(url);

      // التحقق إذا كان يمكن فتح الرابط
      final canLaunch = await url_launcher.canLaunchUrl(uri);

      if (canLaunch) {
        // محاولة فتح الرابط في المتصفح
        final launched = await url_launcher.launchUrl(
          uri,
          mode: url_launcher
              .LaunchMode
              .externalApplication, // استخدام تطبيق خارجي
        );

        if (!launched && context != null) {
          // إذا فشل الفتح، أظهر رسالة خطأ
          _showErrorSnackBar(context, 'فشل في فتح الرابط: $url');
        }
      } else if (context != null) {
        // إذا كان الرابط غير قابل للفتح، أظهر رسالة
        _showErrorSnackBar(context, 'لا يمكن فتح الرابط: $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      if (context != null) {
        _showErrorSnackBar(context, 'حدث خطأ: $e');
      }

      // طريقة بديلة لفتح الرابط
      _tryAlternativeLaunch(url, context);
    }
  }

  // محاولة بديلة لفتح الرابط
  static void _tryAlternativeLaunch(String url, BuildContext? context) async {
    try {
      // محاولة فتح الرابط باستخدام طريقة أخرى
      if (url.startsWith('https://github.com/') ||
          url.startsWith('github.com/')) {
        // استخدم الرابط مع app-link لفتح تطبيق GitHub على الجهاز
        final githubUser = url.replaceAll(
          RegExp(r'https?://(www\.)?github\.com/'),
          '',
        );
        final mobileUrl = 'https://github.com/$githubUser';

        final Uri uri = Uri.parse(mobileUrl);
        await url_launcher.launchUrl(
          uri,
          mode: url_launcher.LaunchMode.externalNonBrowserApplication,
        );
      } else if (url.startsWith('https://linkedin.com/') ||
          url.startsWith('linkedin.com/')) {
        // استخدم رابط مباشر لتطبيق LinkedIn
        final linkedinPath = url.replaceAll(
          RegExp(r'https?://(www\.)?linkedin\.com/'),
          '',
        );
        final mobileUrl = 'https://www.linkedin.com/$linkedinPath';

        final Uri uri = Uri.parse(mobileUrl);
        await url_launcher.launchUrl(
          uri,
          mode: url_launcher.LaunchMode.externalNonBrowserApplication,
        );
      }
    } catch (e) {
      print('Alternative launch also failed: $e');
      if (context != null) {
        _showCopyLinkDialog(context, url);
      }
    }
  }

  // إظهار مربع حوار لنسخ الرابط
  static void _showCopyLinkDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('لا يمكن فتح الرابط'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'لا يمكن فتح الرابط تلقائياً. يمكنك نسخ الرابط ولصقه في المتصفح:',
              ),
              const SizedBox(height: 8),
              Text(url, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                // نسخ الرابط إلى الحافظة
                url_launcher.Clipboard.setData(
                  url_launcher.ClipboardData(text: url),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('تم نسخ الرابط')));
              },
              child: const Text('نسخ الرابط'),
            ),
          ],
        );
      },
    );
  }

  // إظهار شريط إشعار بالخطأ
  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // فتح بريد إلكتروني
  static Future<void> launchEmail(String email, {BuildContext? context}) async {
    try {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);

      final launched = await url_launcher.launchUrl(emailLaunchUri);

      if (!launched && context != null) {
        _showErrorSnackBar(context, 'فشل في فتح تطبيق البريد الإلكتروني');
      }
    } catch (e) {
      print('Error launching email: $e');
      if (context != null) {
        _showErrorSnackBar(context, 'حدث خطأ: $e');
      }
    }
  }

  // فتح رقم هاتف
  static Future<void> launchPhone(String phone, {BuildContext? context}) async {
    try {
      final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);

      final launched = await url_launcher.launchUrl(phoneLaunchUri);

      if (!launched && context != null) {
        _showErrorSnackBar(context, 'فشل في فتح تطبيق الهاتف');
      }
    } catch (e) {
      print('Error launching phone: $e');
      if (context != null) {
        _showErrorSnackBar(context, 'حدث خطأ: $e');
      }
    }
  }

  // فتح وسائل التواصل الاجتماعي
  static Future<void> launchSocialMedia(
    String platform,
    String username, {
    BuildContext? context,
  }) async {
    String url;

    switch (platform.toLowerCase()) {
      case 'github':
        url = 'https://github.com/$username';
        break;
      case 'linkedin':
        url = 'https://linkedin.com/in/$username';
        break;
      case 'twitter':
        url = 'https://twitter.com/$username';
        break;
      case 'facebook':
        url = 'https://facebook.com/$username';
        break;
      case 'instagram':
        url = 'https://instagram.com/$username';
        break;
      default:
        if (context != null) {
          _showErrorSnackBar(context, 'منصة غير مدعومة: $platform');
        }
        return;
    }

    await launchURL(url, context: context);
  }
}
