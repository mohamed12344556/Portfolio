import 'package:flutter/material.dart';

class AnimationConfig {
  final Map<String, AnimationData> animations;
  final List<SectionConfig> sections;
  final GlobalSettings globalSettings;

  AnimationConfig({
    required this.animations,
    required this.sections,
    required this.globalSettings,
  });

  factory AnimationConfig.fromJson(Map<String, dynamic> json) {
    return AnimationConfig(
      animations: (json['animations'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          AnimationData.fromJson(value as Map<String, dynamic>),
        ),
      ),
      sections: (json['sections'] as List)
          .map((section) => SectionConfig.fromJson(section))
          .toList(),
      globalSettings: GlobalSettings.fromJson(json['globalSettings']),
    );
  }
}

class AnimationData {
  final int duration;
  final String curve;
  final int delay;
  final Map<String, dynamic>? properties;

  AnimationData({
    required this.duration,
    required this.curve,
    required this.delay,
    this.properties,
  });

  factory AnimationData.fromJson(Map<String, dynamic> json) {
    return AnimationData(
      duration: json['duration'],
      curve: json['curve'],
      delay: json['delay'],
      properties: json
        ..remove('duration')
        ..remove('curve')
        ..remove('delay'),
    );
  }

  Curve get flutterCurve {
    switch (curve) {
      case 'easeOutCubic':
        return Curves.easeOutCubic;
      case 'easeOutBack':
        return Curves.easeOutBack;
      case 'elasticOut':
        return Curves.elasticOut;
      case 'elasticInOut':
        return Curves.elasticInOut;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'easeInOut':
        return Curves.easeInOut;
      default:
        return Curves.easeOut;
    }
  }
}

class SectionConfig {
  final String name;
  final int index;
  final List<String> animations;
  final String slideDirection;
  final double triggerOffset;

  SectionConfig({
    required this.name,
    required this.index,
    required this.animations,
    required this.slideDirection,
    required this.triggerOffset,
  });

  factory SectionConfig.fromJson(Map<String, dynamic> json) {
    return SectionConfig(
      name: json['name'],
      index: json['index'],
      animations: List<String>.from(json['animations']),
      slideDirection: json['slideDirection'],
      triggerOffset: json['triggerOffset'],
    );
  }

  Offset get slideOffset {
    switch (slideDirection) {
      case 'left':
        return const Offset(-0.3, 0);
      case 'right':
        return const Offset(0.3, 0);
      case 'top':
        return const Offset(0, -0.3);
      case 'bottom':
      default:
        return const Offset(0, 0.3);
    }
  }
}

class GlobalSettings {
  final int staggerDelay;
  final double visibilityThreshold;
  final bool enableParallax;
  final bool enableHover;

  GlobalSettings({
    required this.staggerDelay,
    required this.visibilityThreshold,
    required this.enableParallax,
    required this.enableHover,
  });

  factory GlobalSettings.fromJson(Map<String, dynamic> json) {
    return GlobalSettings(
      staggerDelay: json['staggerDelay'],
      visibilityThreshold: json['visibilityThreshold'],
      enableParallax: json['enableParallax'],
      enableHover: json['enableHover'],
    );
  }
}
