import 'package:flutter/material.dart';

// Enhanced Responsive utility class
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

  // Updated breakpoints for better responsiveness
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  // Additional helper methods
  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 400;

  static bool isLargeMobile(BuildContext context) =>
      MediaQuery.of(context).size.width >= 400 &&
      MediaQuery.of(context).size.width < 600;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 1200) {
      return desktop;
    } else if (size.width >= 600 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

// Enhanced ResponsivePadding class
class ResponsivePadding {
  static EdgeInsets getHorizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return EdgeInsets.symmetric(
        horizontal: width * 0.08,
      ); // 8% of screen width
    } else if (width >= 600) {
      return EdgeInsets.symmetric(
        horizontal: width * 0.06,
      ); // 6% of screen width
    } else {
      return const EdgeInsets.symmetric(horizontal: 16);
    }
  }

  static EdgeInsets getAll(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const EdgeInsets.all(32);
    } else if (Responsive.isTablet(context)) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  static EdgeInsets getSymmetric(
    BuildContext context, {
    double? horizontal,
    double? vertical,
  }) {
    final h =
        horizontal ??
        (Responsive.isDesktop(context)
            ? 32
            : Responsive.isTablet(context)
            ? 24
            : 16);
    final v =
        vertical ??
        (Responsive.isDesktop(context)
            ? 32
            : Responsive.isTablet(context)
            ? 24
            : 16);
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  static EdgeInsets getContentPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1400) {
      return EdgeInsets.symmetric(horizontal: (width - 1200) / 2);
    } else if (width >= 1200) {
      return const EdgeInsets.symmetric(horizontal: 40);
    } else if (width >= 600) {
      return const EdgeInsets.symmetric(horizontal: 32);
    } else {
      return const EdgeInsets.symmetric(horizontal: 16);
    }
  }

  static double getContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1400) {
      return 1200;
    } else if (width >= 1200) {
      return width * 0.9;
    } else if (width >= 600) {
      return width * 0.95;
    } else {
      return width;
    }
  }
}

// Enhanced ResponsiveGridView
class ResponsiveGridView extends StatelessWidget {
  final List<Widget> children;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final ScrollController? controller;
  final bool shrinkWrap;
  final ScrollPhysics physics;
  final int? maxCrossAxisExtent;

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.controller,
    this.shrinkWrap = true,
    this.physics = const NeverScrollableScrollPhysics(),
    this.maxCrossAxisExtent,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = _getSpacing(context);

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: controller,
      gridDelegate: maxCrossAxisExtent != null
          ? SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCrossAxisExtent!.toDouble(),
              childAspectRatio:
                  childAspectRatio ?? _getChildAspectRatio(context),
              crossAxisSpacing: crossAxisSpacing ?? spacing,
              mainAxisSpacing: mainAxisSpacing ?? spacing,
            )
          : SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              childAspectRatio:
                  childAspectRatio ?? _getChildAspectRatio(context),
              crossAxisSpacing: crossAxisSpacing ?? spacing,
              mainAxisSpacing: mainAxisSpacing ?? spacing,
            ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1200) {
      return 4;
    } else if (width >= 900) {
      return 3;
    } else if (width >= 600) {
      return 2;
    } else {
      return 1;
    }
  }

  double _getChildAspectRatio(BuildContext context) {
    return Responsive.isMobile(context) ? 0.8 : 1.0;
  }

  double _getSpacing(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return crossAxisSpacing ?? 20;
    } else if (Responsive.isTablet(context)) {
      return crossAxisSpacing ?? 16;
    } else {
      return crossAxisSpacing ?? 12;
    }
  }
}
