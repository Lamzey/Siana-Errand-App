import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siana_erran_app/core/utils/assets_utiles.dart';

// Main Launch Screen Widget
class LaunchScreen extends StatefulWidget {
  final String? logoAsset;
  final Color backgroundColor;
  final Color logoColor;
  final double logoSize;
  final Duration animationDuration;
  final VoidCallback? onAnimationComplete;
  final bool showLoadingIndicator;
  final Duration displayDuration;

  const LaunchScreen({
    Key? key,
    this.logoAsset = '${iconPath}siana_ic.png',
    this.backgroundColor = const Color(0xFF2D3748),
    this.logoColor = Colors.white,
    this.logoSize = 120,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.onAnimationComplete,
    this.showLoadingIndicator = false,
    this.displayDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startLaunchSequence();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Fade controller for screen transition
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Logo scale animation (bouncy entrance)
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Logo opacity animation
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Screen fade animation
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
  }

  void _startLaunchSequence() async {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: widget.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    // Start logo animation
    await _logoController.forward();

    // Wait for display duration
    await Future.delayed(widget.displayDuration);

    // Start fade out animation
    await _fadeController.forward();

    // Call completion callback
    if (widget.onAnimationComplete != null) {
      widget.onAnimationComplete!();
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Main content area
                    Expanded(
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _logoController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _logoScaleAnimation.value,
                              child: Opacity(
                                opacity: _logoOpacityAnimation.value,
                                child: LogoWidget(
                                  logoAsset: widget.logoAsset,
                                  size: widget.logoSize,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    
                    // Loading indicator (optional)
                    if (widget.showLoadingIndicator)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: LoadingIndicator(
                          color: widget.logoColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Logo Widget Component
class LogoWidget extends StatelessWidget {
  final String? logoAsset;
  final double size;
  final Color? color;

  const LogoWidget({
    Key? key,
    required this.logoAsset,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (logoAsset != null && logoAsset!.isNotEmpty) {
      return Image.asset(
        logoAsset!,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey,
              size: size * 0.4,
            ),
          );
        },
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.image,
        color: Colors.grey,
        size: size * 0.4,
      ),
    );
  }
}



// Loading Indicator Component
class LoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const LoadingIndicator({
    Key? key,
    required this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: LoadingPainter(
              color: widget.color,
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

// Loading Painter
class LoadingPainter extends CustomPainter {
  final Color color;
  final double progress;

  LoadingPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Draw background circle
    canvas.drawCircle(center, radius, paint);

    // Draw progress arc
    final sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Launch Screen Controller
class LaunchScreenController {
  static Future<void> show(
    BuildContext context, {
    String? logoAsset,
    Color backgroundColor = const Color(0xFF2D3748),
    Color logoColor = Colors.white,
    double logoSize = 120,
    Duration animationDuration = const Duration(milliseconds: 1500),
    Duration displayDuration = const Duration(seconds: 3),
    bool showLoadingIndicator = false,
    required Widget nextScreen,
  }) async {
    await Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return LaunchScreen(
            logoAsset: logoAsset,
            backgroundColor: backgroundColor,
            logoColor: logoColor,
            logoSize: logoSize,
            animationDuration: animationDuration,
            displayDuration: displayDuration,
            showLoadingIndicator: showLoadingIndicator,
            onAnimationComplete: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => nextScreen),
              );
            },
          );
        },
        transitionDuration: Duration.zero,
      ),
    );
  }
}

