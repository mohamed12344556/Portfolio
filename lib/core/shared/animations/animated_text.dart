import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration animationDuration;
  final Duration animationDelay;
  final Curve animationCurve;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;
  final double scrollEndOffset;

  const AnimatedText({
    super.key,
    required this.text,
    this.style,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationDelay = Duration.zero,
    this.animationCurve = Curves.easeOutCubic,
    this.textAlign,
    this.maxLines,
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
    this.scrollEndOffset = 0.5,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve),
        );

    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScrollListener);
    } else {
      Future.delayed(widget.animationDelay, () {
        if (mounted) {
          _isVisible = true;
          _controller.forward();
        }
      });
    }
  }

  void _handleScrollListener() {
    if (!widget.animateOnScroll || widget.scrollController == null) return;

    // ربط التمرير بالظهور
    final double scrollPosition = widget.scrollController!.position.pixels;
    final double maxScrollExtent =
        widget.scrollController!.position.maxScrollExtent;

    // حساب نسبة التمرير
    final double scrollPercentage = scrollPosition / maxScrollExtent;

    // تحديد ما إذا كان يجب عرض النص بناءً على نسبة التمرير
    if (scrollPercentage >= widget.scrollStartOffset &&
        scrollPercentage <= widget.scrollEndOffset &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
      });
      _controller.forward();
    } else if ((scrollPercentage < widget.scrollStartOffset ||
            scrollPercentage > widget.scrollEndOffset) &&
        _isVisible &&
        widget.scrollEndOffset < 1.0) {
      setState(() {
        _isVisible = false;
      });
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
              maxLines: widget.maxLines,
              overflow: widget.maxLines != null ? TextOverflow.ellipsis : null,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final Duration animationDuration;
  final Duration animationDelay;
  final Curve animationCurve;
  final TextAlign? textAlign;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;
  final double scrollEndOffset;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationDelay = Duration.zero,
    this.animationCurve = Curves.easeOutCubic,
    this.textAlign,
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
    this.scrollEndOffset = 0.5,
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.animationCurve),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve),
        );

    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScrollListener);
    } else {
      Future.delayed(widget.animationDelay, () {
        if (mounted) {
          _isVisible = true;
          _controller.forward();
        }
      });
    }
  }

  void _handleScrollListener() {
    if (!widget.animateOnScroll || widget.scrollController == null) return;

    // ربط التمرير بالظهور
    final double scrollPosition = widget.scrollController!.position.pixels;
    final double maxScrollExtent =
        widget.scrollController!.position.maxScrollExtent;

    // حساب نسبة التمرير
    final double scrollPercentage = scrollPosition / maxScrollExtent;

    // تحديد ما إذا كان يجب عرض النص بناءً على نسبة التمرير
    if (scrollPercentage >= widget.scrollStartOffset &&
        scrollPercentage <= widget.scrollEndOffset &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
      });
      _controller.forward();
    } else if ((scrollPercentage < widget.scrollStartOffset ||
            scrollPercentage > widget.scrollEndOffset) &&
        _isVisible &&
        widget.scrollEndOffset < 1.0) {
      setState(() {
        _isVisible = false;
      });
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ShaderMask(
              shaderCallback: (bounds) => widget.gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                widget.text,
                style: (widget.style ?? const TextStyle()).copyWith(
                  color: Colors.white,
                ),
                textAlign: widget.textAlign,
              ),
            ),
          ),
        );
      },
    );
  }
}

class TypewriterAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration initialDelay;
  final bool animateOnScroll;
  final ScrollController? scrollController;
  final double scrollStartOffset;

  const TypewriterAnimatedText({
    super.key,
    required this.text,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 50),
    this.initialDelay = Duration.zero,
    this.animateOnScroll = false,
    this.scrollController,
    this.scrollStartOffset = 0.0,
  });

  @override
  State<TypewriterAnimatedText> createState() => _TypewriterAnimatedTextState();
}

class _TypewriterAnimatedTextState extends State<TypewriterAnimatedText> {
  String _displayedText = '';
  bool _isAnimating = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.addListener(_handleScrollListener);
    } else {
      _startAnimation();
    }
  }

  void _handleScrollListener() {
    if (!widget.animateOnScroll || widget.scrollController == null) return;

    final double scrollPosition = widget.scrollController!.position.pixels;
    final double maxScrollExtent =
        widget.scrollController!.position.maxScrollExtent;
    final double scrollPercentage = scrollPosition / maxScrollExtent;

    if (scrollPercentage >= widget.scrollStartOffset && !_isAnimating) {
      _startAnimation();
    }
  }

  void _startAnimation() async {
    if (_isAnimating || _displayedText == widget.text) return;

    _isAnimating = true;

    // تطبيق التأخير الأولي
    await Future.delayed(widget.initialDelay);

    if (!mounted) return;

    // بدء الكتابة الآلية
    _currentIndex = 0;
    _displayedText = '';

    while (_currentIndex < widget.text.length && mounted) {
      setState(() {
        _displayedText = widget.text.substring(0, _currentIndex + 1);
        _currentIndex++;
      });

      await Future.delayed(widget.typingSpeed);
    }

    _isAnimating = false;
  }

  @override
  void dispose() {
    if (widget.animateOnScroll && widget.scrollController != null) {
      widget.scrollController!.removeListener(_handleScrollListener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}
