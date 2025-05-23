import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_portfolio/core/themes/app_theme.dart';

import 'features/home/presentation/screens/portfolio_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Mohamed Abdelqawi - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const PortfolioScreen(),
    );
  }
}
