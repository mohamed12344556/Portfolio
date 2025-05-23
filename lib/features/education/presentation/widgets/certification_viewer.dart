import 'dart:html' as html;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../../../core/themes/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateViewer extends StatefulWidget {
  final String title;
  final String pdfUrl;

  const CertificateViewer({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  @override
  State<CertificateViewer> createState() => _CertificateViewerState();

  static void showCertificate(
    BuildContext context,
    String title,
    String pdfUrl,
  ) {
    showDialog(
      context: context,
      builder: (context) => CertificateViewer(title: title, pdfUrl: pdfUrl),
    );
  }
}

class _CertificateViewerState extends State<CertificateViewer> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCard
              : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.download, color: Colors.white),
                        onPressed: () {
                          // قم بتنزيل الشهادة
                          _downloadCertificate(widget.pdfUrl);
                        },
                        tooltip: 'Download Certificate',
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  SfPdfViewer.asset(
                    // pdfSource,
                    widget.pdfUrl,
                    initialZoomLevel: 1.0,
                    canShowScrollHead: true,
                    canShowScrollStatus: true,
                    canShowPaginationDialog: true,
                    onDocumentLoaded: (details) {
                      setState(() => isLoading = false);
                    },
                    onDocumentLoadFailed: (error) {
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'فشل تحميل الـ PDF $widget.pdfUrl \n${error.description}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkSecondary
                    : AppColors.lightSecondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.open_in_new),
                    label: Text("Open in Browser"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      _openInBrowser(widget.pdfUrl, context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfPreview(bool isLoading) {
    // هذا مجرد نموذج، يمكنك استبداله بمكتبة PDF حقيقية
    if (widget.pdfUrl.isNotEmpty) {
      return SfPdfViewer.asset(
        widget.pdfUrl,
        initialZoomLevel: 1.0,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        onDocumentLoaded: (_) => setState(() => isLoading = false),
        onDocumentLoadFailed: (_) => setState(() => isLoading = false),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.picture_as_pdf, size: 100, color: AppColors.primaryColor),
        SizedBox(height: 20),
        Text(
          "PDF Preview",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        Text(widget.title, style: TextStyle(fontSize: 18)),
        SizedBox(height: 30),
        Text("Loading PDF Document...", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  // void _downloadCertificate(String url) {
  //   // تنفيذ تنزيل الشهادة
  //   // يمكن استخدام مكتبة dio أو http للتنزيل
  //   // مثال بسيط:
  //   // Dio dio = Dio();
  //   // dio.download(url, 'certificate.pdf');
  //   print("Downloading certificate from: $url");
  // }
  void _downloadCertificate(String url) async {
    if (kIsWeb) {
      // على الويب: أنشئ عنصر <a download>
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', '') // اسم افتراضي؛ تستطيع تغييره
        ..click();
    } else {
      // على الموبايل/دسكتوب: استخدم Dio لتحميل الملف إلى مساحة التخزين
      final dio = Dio();
      final dir = '/storage/emulated/0/Download'; // مثال لمجلد على أندرويد
      final savePath = '$dir/certificate.pdf';

      try {
        await dio.download(
          url,
          savePath,
          onReceiveProgress: (received, total) {
            // تستطيع هنا تحديث ProgressIndicator
          },
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('تم تنزيل الملف في: $savePath')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('فشل التنزيل: $e')));
      }
    }
  }
}

Future<void> _openInBrowser(String assetPath, BuildContext context) async {
  if (kIsWeb) {
    // على الويب: وجه المسار النسبي للأصول إلى URL كامل
    final origin = Uri.base.origin;
    final url = '$origin/$assetPath';
    html.window.open(url, '_blank');
    return;
  }

  try {
    // على الموبايل/دسكتوب: انسخ الـ asset لملف مؤقت ثم افتحه
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = File(p.join(tempDir.path, p.basename(assetPath)));
    await file.writeAsBytes(bytes, flush: true);

    final uri = file.uri;
    if (!await canLaunchUrl(uri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('لا يمكن فتح الملف')));
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    debugPrint('Error opening asset: $e');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
  }
}

// مكون Chip محسن للشهادات مع ميزة العرض
class EnhancedCertificationChip extends StatefulWidget {
  final String title;
  final bool isDark;
  final String pdfUrl;

  const EnhancedCertificationChip({
    super.key,
    required this.title,
    required this.isDark,
    required this.pdfUrl,
  });

  @override
  State<EnhancedCertificationChip> createState() =>
      _EnhancedCertificationChipState();
}

class _EnhancedCertificationChipState extends State<EnhancedCertificationChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // عرض الشهادة عند النقر
          CertificateViewer.showCertificate(
            context,
            widget.title,
            widget.pdfUrl,
          );
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primaryColor.withOpacity(0.2)
                : widget.isDark
                ? AppColors.darkCard
                : AppColors.lightCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primaryColor
                  : widget.isDark
                  ? AppColors.darkBorder
                  : AppColors.lightBorder,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified,
                size: 16,
                color: _isHovered ? AppColors.primaryColor : Colors.grey,
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isDark
                        ? AppColors.textDark
                        : AppColors.textLight,
                    fontSize: 14,
                    fontWeight: _isHovered
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 5),
              if (_isHovered)
                Icon(Icons.visibility, size: 16, color: AppColors.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
