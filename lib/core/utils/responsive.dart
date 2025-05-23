import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 1024) {
      return desktop;
    } else if (size.width >= 768 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

class ResponsivePadding {
  static EdgeInsets get horizontal {
    return const EdgeInsets.symmetric(horizontal: 20);
  }

  static EdgeInsets getHorizontal(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 80);
    } else if (Responsive.isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40);
    } else {
      return const EdgeInsets.symmetric(horizontal: 20);
    }
  }

  static EdgeInsets getAll(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const EdgeInsets.all(80);
    } else if (Responsive.isTablet(context)) {
      return const EdgeInsets.all(40);
    } else {
      return const EdgeInsets.all(20);
    }
  }

  static double getContentWidth(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 1200;
    } else if (Responsive.isTablet(context)) {
      return 768;
    } else {
      return double.infinity;
    }
  }
}

class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollController? controller;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    this.controller,
  });

  @override

  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return 3;
    } else if (Responsive.isTablet(context)) {
      return 2;
    } else {
      return 1;
    }
  }
}
