import 'package:flutter/material.dart';

class DeliveryHeader extends StatefulWidget {
  const DeliveryHeader({super.key});

  @override
  State<DeliveryHeader> createState() => _DeliveryHeaderState();
}

class _DeliveryHeaderState extends State<DeliveryHeader>
    with TickerProviderStateMixin {
  late AnimationController _deliveryTextController;
  late Animation<double> _deliveryTextAnimation;
  late AnimationController _scooterController;
  late Animation<double> _scooterAnimation;
  late AnimationController _typingController;
  late Animation<double> _typingAnimation;
  int _currentTextIndex = 0;
  final List<String> _deliveryTexts = [
    "A100/11 Ghonda New Delhi(110001)",
    "Quick delivery in 10 minutes",
  ];
  String _visibleText = '';
  final String _fullText = "Quick delivery in 10 minutes";
  int _currentCharIndex = 0;

  // Get theme colors
  Color get royalGreen => Theme.of(context).colorScheme.primary;
  Color get textPrimary =>
      Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
  Color get textSecondary =>
      Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
  Color get cardBackground => Theme.of(context).cardColor;

  @override
  void initState() {
    super.initState();

    // Initialize delivery text animation
    _deliveryTextController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _deliveryTextAnimation = CurvedAnimation(
      parent: _deliveryTextController,
      curve: Curves.easeInOut,
    );

    // Initialize scooter animation
    _scooterController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scooterAnimation = CurvedAnimation(
      parent: _scooterController,
      curve: Curves.easeInOut,
    );

    // Initialize typing animation
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _typingAnimation = CurvedAnimation(
      parent: _typingController,
      curve: Curves.easeInOut,
    );

    _typingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _visibleText = _fullText;
        });
      }
    });

    // Start the text sequence
    _startTextSequence();
  }

  void _startTextSequence() {
    _deliveryTextController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentTextIndex = (_currentTextIndex + 1) % _deliveryTexts.length;
          if (_currentTextIndex == 1) {
            // Reset and start scooter animation when showing "Quick delivery" text
            _scooterController.reset();
            _scooterController.forward();
            // Reset typing animation
            _currentCharIndex = 0;
            _visibleText = '';
            _typingController.reset();
            _typingController.forward();
          }
        });
        _deliveryTextController.reset();
        _deliveryTextController.forward();
      }
    });
    _deliveryTextController.forward();
  }

  @override
  void dispose() {
    _deliveryTextController.dispose();
    _scooterController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _deliveryTextAnimation,
      builder: (context, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedBuilder(
                      animation: _scooterAnimation,
                      builder: (context, child) {
                        final progress = _scooterAnimation.value;
                        final textWidth =
                            MediaQuery.of(context).size.width * 0.6;
                        final scooterPosition = textWidth * progress;
                        final charWidth = textWidth / _fullText.length;
                        final currentCharIndex =
                            (scooterPosition / charWidth).floor();
                        if (currentCharIndex > _currentCharIndex &&
                            currentCharIndex < _fullText.length) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _currentCharIndex = currentCharIndex;
                              _visibleText = _fullText.substring(
                                0,
                                _currentCharIndex + 1,
                              );
                            });
                          });
                        }
                        return Transform.translate(
                          offset: Offset(
                            _currentTextIndex == 1 ? scooterPosition : 0,
                            0,
                          ),
                          child: Opacity(
                            opacity:
                                _currentTextIndex == 1
                                    ? (1.0 - progress).clamp(0.0, 1.0)
                                    : 1.0,
                            child: Icon(
                              _currentTextIndex == 0
                                  ? Icons.location_on
                                  : Icons.electric_bike,
                              color: royalGreen,
                              size: 22,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        _currentTextIndex == 0
                            ? Column(
                              key: const ValueKey('address'),
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery to",
                                  style: TextStyle(
                                    color: textSecondary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  _deliveryTexts[_currentTextIndex],
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                            : Center(
                              key: const ValueKey('delivery'),
                              child: Text(
                                _visibleText,
                                style: TextStyle(
                                  color: royalGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
