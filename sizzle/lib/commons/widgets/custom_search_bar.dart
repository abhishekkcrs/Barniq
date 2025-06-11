import 'package:flutter/material.dart';
import 'dart:async';

class CustomSearchBar extends StatefulWidget {
  final VoidCallback onSearchTap;
  final Function(String) onSearchChanged;
  final List<String> searchSuggestions;
  final bool isLoading;
  final String? initialSearchText;

  const CustomSearchBar({
    super.key,
    required this.onSearchTap,
    required this.onSearchChanged,
    required this.searchSuggestions,
    this.isLoading = false,
    this.initialSearchText,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _borderController;
  late Animation<double> _borderAnimation;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> searchIcons = [
    {'icon': Icons.apple, 'text': 'Fruits'},
    {'icon': Icons.eco, 'text': 'Vegetables'},
    {'icon': Icons.local_drink, 'text': 'Dairy'},
    {'icon': Icons.bakery_dining, 'text': 'Bakery'},
    {'icon': Icons.local_grocery_store, 'text': 'Groceries'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _startAnimation();

    // Initialize border animation controller
    _borderController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _borderAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_borderController);

    _searchController.addListener(_onSearchChanged);

    // Set initial search text if provided
    if (widget.initialSearchText != null) {
      _searchController.text = widget.initialSearchText!;
      _isSearching = true;
    }
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      _currentIndex = (_currentIndex + 1) % searchIcons.length;
      _controller.reset();
      _startAnimation();
    });
  }

  void _onSearchChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _borderController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedHintText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isSearching)
            Text('',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.grey)),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    searchIcons[_currentIndex]['icon'],
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    searchIcons[_currentIndex]['text'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchBarBackground =
        Theme.of(context).inputDecorationTheme.fillColor ??
            Theme.of(context).scaffoldBackgroundColor;
    final textPrimary =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final textSecondary =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    final summerAccent = const Color(0xFFFF9800);
    final summerBlue = const Color(0xFF4FC3F7);

    return GestureDetector(
      onTap: widget.onSearchTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: AnimatedBuilder(
          animation: _borderAnimation,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    summerAccent.withOpacity(0.8),
                    summerBlue.withOpacity(0.8),
                    summerAccent.withOpacity(0.8),
                  ],
                  stops: [
                    _borderAnimation.value - 0.2,
                    _borderAnimation.value,
                    _borderAnimation.value + 0.2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: summerAccent.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: searchBarBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  enabled: false,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: _isSearching ? null : 'Search products...',
                    hintStyle: TextStyle(
                      color: textSecondary,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          16), // <-- your border radius here
                      borderSide: BorderSide.none, // <-- no visible border line
                    ),
                    prefixIcon: _buildAnimatedHintText(),
                    suffixIcon: Icon(
                      Icons.search,
                      color: summerAccent,
                      size: 24,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
