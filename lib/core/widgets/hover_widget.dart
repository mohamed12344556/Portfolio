import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  final Duration duration;
  final Curve curve;

  const HoverWidget({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedSwitcher(
        duration: widget.duration,
        switchInCurve: widget.curve,
        switchOutCurve: widget.curve,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: widget.builder(_isHovered),
      ),
    );
  }
}

class ScaleOnHover extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;
  final Curve curve;

  const ScaleOnHover({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  @override
  State<ScaleOnHover> createState() => _ScaleOnHoverState();
}

class _ScaleOnHoverState extends State<ScaleOnHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.scale : 1.0,
        duration: widget.duration,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}

class TranslateOnHover extends StatefulWidget {
  final Widget child;
  final Offset offset;
  final Duration duration;
  final Curve curve;

  const TranslateOnHover({
    super.key,
    required this.child,
    this.offset = const Offset(0, -10),
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  @override
  State<TranslateOnHover> createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        transform: Matrix4.translationValues(
          _isHovered ? widget.offset.dx : 0,
          _isHovered ? widget.offset.dy : 0,
          0,
        ),
        child: widget.child,
      ),
    );
  }
}
