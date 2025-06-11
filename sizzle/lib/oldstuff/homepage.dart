// import "package:flutter/material.dart";
// import "dart:async";
// import 'dart:convert';
// import '../pages/cart_page.dart';
// import '../routes.dart';
// import 'package:sizzle/pages/profile_page.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sizzle/providers/auth_provider.dart';
// import 'package:sizzle/utils/tab_categories.dart';
// import 'package:sizzle/commons/widgets/custom_search_bar.dart';
// import 'package:sizzle/commons/widgets/delivery_header.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late AnimationController _borderController;
//   late Animation<double> _borderAnimation;
//   late AnimationController _deliveryTextController;
//   late Animation<double> _deliveryTextAnimation;
//   late AnimationController _scooterController;
//   late Animation<double> _scooterAnimation;
//   final List<AnimationController> _imageControllers = [];
//   final List<Animation<double>> _imageAnimations = [];
//   final List<int> _currentImageIndices = [];
//   int _currentIndex = 0;
//   final TextEditingController _searchController = TextEditingController();
//   bool _isSearching = false;
//   int _selectedTabIndex = 0;
//   bool _showPopupMenu = false;
//   late AnimationController _popupController;
//   late Animation<double> _popupAnimation;
//   int _currentFeaturedIndex = 0;
//   late PageController _featuredPageController;
//   Timer? _featuredTimer;
//   List<Map<String, dynamic>> _featuredProducts = [];
//   bool _isSearchActive = false;
//   List<String> _searchSuggestions = [];
//   late AnimationController _searchAnimationController;
//   late Animation<double> _searchAnimation;
//   final FocusNode _searchFocusNode = FocusNode();
//   // Add new animation controllers for dots
//   late List<AnimationController> _dotControllers;
//   late List<Animation<double>> _dotAnimations;
//   int _currentTextIndex = 0;
//   final List<String> _deliveryTexts = [
//     "A100/11 Ghonda New Delhi(110001)",
//     "Quick delivery in 10 minutes",
//   ];
//   late AnimationController _typingController;
//   late Animation<double> _typingAnimation;
//   String _visibleText = '';
//   final String _fullText = "Quick delivery in 10 minutes";
//   int _currentCharIndex = 0;

//   // Get theme colors
//   Color get royalGreen => Theme.of(context).colorScheme.primary;
//   Color get lightBackground => Theme.of(context).scaffoldBackgroundColor;
//   Color get cardBackground => Theme.of(context).cardColor;
//   Color get textPrimary =>
//       Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
//   Color get textSecondary =>
//       Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
//   Color get summerAccent => const Color(0xFFFF9800);
//   Color get summerBlue => const Color(0xFF4FC3F7);
//   Color get searchBarBackground =>
//       Theme.of(context).inputDecorationTheme.fillColor ?? lightBackground;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _startAnimation();

//     // Initialize border animation controller
//     _borderController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();
//     _borderAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(_borderController);

//     // Initialize image indices for each featured item
//     for (int i = 0; i < tabCategories.length; i++) {
//       _currentImageIndices.add(0);
//       _startImageChange(i);
//     }

//     _searchController.addListener(_onSearchChanged);

//     // Initialize popup menu animation controller
//     _popupController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _popupAnimation = CurvedAnimation(
//       parent: _popupController,
//       curve: Curves.easeInOut,
//     );

//     _featuredPageController = PageController();
//     _startFeaturedTimer();

//     // Add this line to load featured products
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadFeaturedProducts();
//     });

//     // Initialize search animation controller
//     _searchAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _searchAnimation = CurvedAnimation(
//       parent: _searchAnimationController,
//       curve: Curves.easeInOut,
//     );

//     _searchFocusNode.addListener(() {
//       if (_searchFocusNode.hasFocus) {
//         _activateSearch();
//       }
//     });

//     // Initialize delivery text animation
//     _deliveryTextController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     )..repeat();

//     _deliveryTextAnimation = CurvedAnimation(
//       parent: _deliveryTextController,
//       curve: Curves.easeInOut,
//     );

//     // Initialize scooter animation
//     _scooterController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _scooterAnimation = CurvedAnimation(
//       parent: _scooterController,
//       curve: Curves.easeInOut,
//     );

//     // Start the text sequence
//     _startTextSequence();

//     // Initialize typing animation
//     _typingController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//     _typingAnimation = CurvedAnimation(
//       parent: _typingController,
//       curve: Curves.easeInOut,
//     );

//     _typingController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _visibleText = _fullText;
//         });
//       }
//     });
//   }

//   void _startAnimation() {
//     _controller.forward().then((_) {
//       _currentIndex = (_currentIndex + 1) % searchIcons.length;
//       _controller.reset();
//       _startAnimation();
//     });
//   }

//   void _startImageChange(int index) {
//     if (!mounted) return;

//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (!mounted) return;

//       setState(() {
//         // Randomly select next image index
//         int nextIndex;
//         do {
//           nextIndex = (DateTime.now().millisecondsSinceEpoch % 3);
//         } while (nextIndex == _currentImageIndices[index]);
//         _currentImageIndices[index] = nextIndex;
//       });

//       if (mounted) {
//         _startImageChange(index);
//       }
//     });
//   }

//   void _onSearchChanged() {
//     setState(() {
//       _isSearching = _searchController.text.isNotEmpty;
//     });
//   }

//   void _togglePopupMenu() {
//     setState(() {
//       _showPopupMenu = !_showPopupMenu;
//       if (_showPopupMenu) {
//         _popupController.forward();
//       } else {
//         _popupController.reverse();
//       }
//     });
//   }

//   void _startFeaturedTimer() {
//     _featuredTimer?.cancel();
//     _featuredTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (_featuredProducts.isEmpty) return;

//       if (_currentFeaturedIndex < _featuredProducts.length - 1) {
//         _currentFeaturedIndex++;
//       } else {
//         _currentFeaturedIndex = 0;
//       }
//       if (_featuredPageController.hasClients) {
//         _featuredPageController.animateToPage(
//           _currentFeaturedIndex,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   Future<void> _loadFeaturedProducts() async {
//     try {
//       print('Loading featured products...');
//       // Get list of files in the featured directory
//       final manifestContent = await DefaultAssetBundle.of(
//         context,
//       ).loadString('AssetManifest.json');
//       print('Asset manifest content: $manifestContent');

//       final Map<String, dynamic> manifestMap = json.decode(manifestContent);
//       print('Manifest map: $manifestMap');

//       // Filter for featured images
//       final imagePaths = manifestMap.keys
//           .where((String key) => key.startsWith('assets/images/featured/'))
//           .where(
//             (String key) =>
//                 key.toLowerCase().endsWith('.jpg') ||
//                 key.toLowerCase().endsWith('.jpeg') ||
//                 key.toLowerCase().endsWith('.png'),
//           )
//           .toList();

//       print('Found image paths: $imagePaths');

//       setState(() {
//         _featuredProducts = imagePaths.map((path) {
//           // Extract filename without extension to use as title
//           final filename = path.split('/').last.split('.').first;
//           final title = filename
//               .split('_')
//               .map((word) => word[0].toUpperCase() + word.substring(1))
//               .join(' ');

//           // Assign a color based on the filename
//           final color = _getColorForTitle(title);

//           return {
//             'image': path,
//             'title': title,
//             'subtitle': 'Special Offer',
//             'color': color,
//           };
//         }).toList();
//         print('Created featured products: $_featuredProducts');

//         // Initialize dot animations after featured products are loaded
//         _dotControllers = List.generate(
//           _featuredProducts.length,
//           (index) => AnimationController(
//             duration: const Duration(milliseconds: 300),
//             vsync: this,
//           ),
//         );
//         _dotAnimations = _dotControllers.map((controller) {
//           return Tween<double>(begin: 1.0, end: 1.3).animate(
//             CurvedAnimation(
//               parent: controller,
//               curve: Curves.easeInOut,
//             ),
//           );
//         }).toList();

//         // Start with first dot expanded
//         if (_dotControllers.isNotEmpty) {
//           _dotControllers[0].forward();
//         }
//       });
//     } catch (e, stackTrace) {
//       print('Error loading featured products: $e');
//       print('Stack trace: $stackTrace');
//       // Fallback to empty list if there's an error
//       setState(() {
//         _featuredProducts = [];
//         _dotControllers = [];
//         _dotAnimations = [];
//       });
//     }
//   }

//   Color _getColorForTitle(String title) {
//     // Create a deterministic color based on the title
//     final hash = title.codeUnits.reduce((value, element) => value + element);
//     final colors = [
//       const Color(0xFFFF9800), // Orange
//       const Color(0xFF4CAF50), // Green
//       const Color(0xFF2196F3), // Blue
//       const Color(0xFFE91E63), // Pink
//       const Color(0xFF9C27B0), // Purple
//       const Color(0xFF795548), // Brown
//     ];
//     return colors[hash % colors.length];
//   }

//   void _startTextSequence() {
//     _deliveryTextController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {
//           _currentTextIndex = (_currentTextIndex + 1) % _deliveryTexts.length;
//           if (_currentTextIndex == 1) {
//             // Reset and start scooter animation when showing "Quick delivery" text
//             _scooterController.reset();
//             _scooterController.forward();
//             // Reset typing animation
//             _currentCharIndex = 0;
//             _visibleText = '';
//             _typingController.reset();
//             _typingController.forward();
//           }
//         });
//         _deliveryTextController.reset();
//         _deliveryTextController.forward();
//       }
//     });
//     _deliveryTextController.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _borderController.dispose();
//     _searchController.dispose();
//     _popupController.dispose();
//     _featuredTimer?.cancel();
//     _featuredPageController.dispose();
//     _searchAnimationController.dispose();
//     _searchFocusNode.dispose();
//     for (var controller in _dotControllers) {
//       controller.dispose();
//     }
//     _deliveryTextController.dispose();
//     _scooterController.dispose();
//     _typingController.dispose();
//     super.dispose();
//   }

//   Widget _buildAnimatedHintText() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (!_isSearching)
//             Text('Search for ', style: TextStyle(color: textSecondary)),
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     searchIcons[_currentIndex]['icon'],
//                     color: royalGreen,
//                     size: 16,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     searchIcons[_currentIndex]['text'],
//                     style: TextStyle(
//                       color: royalGreen,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPopupMenu() {
//     return Positioned(
//       bottom: 85,
//       left: 0,
//       right: 0,
//       child: ScaleTransition(
//         scale: _popupAnimation,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Curved connector
//             CustomPaint(
//               size: const Size(2, 40),
//               painter: CurvedConnectorPainter(
//                 color: tabCategories[_selectedTabIndex]['color'].withOpacity(
//                   0.3,
//                 ),
//               ),
//             ),
//             // Menu container
//             Container(
//               width: MediaQuery.of(context).size.width * 0.75,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               decoration: BoxDecoration(
//                 color: cardBackground,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//                 border: Border.all(
//                   color: tabCategories[_selectedTabIndex]['color'].withOpacity(
//                     0.2,
//                   ),
//                   width: 1,
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _buildPopupMenuItem(
//                     icon: Icons.person_outline,
//                     label: 'Profile',
//                     onTap: () {
//                       _togglePopupMenu();
//                       // Navigate to profile
//                     },
//                   ),
//                   _buildPopupMenuItem(
//                     icon: Icons.shopping_bag_outlined,
//                     label: 'Orders',
//                     onTap: () {
//                       _togglePopupMenu();
//                       // Navigate to orders
//                     },
//                   ),
//                   _buildPopupMenuItem(
//                     icon: Icons.favorite_border,
//                     label: 'Wishlist',
//                     onTap: () {
//                       _togglePopupMenu();
//                       // Navigate to wishlist
//                     },
//                   ),
//                   _buildPopupMenuItem(
//                     icon: Icons.settings_outlined,
//                     label: 'Settings',
//                     onTap: () {
//                       _togglePopupMenu();
//                       // Navigate to settings
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPopupMenuItem({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           children: [
//             Icon(icon, color: textPrimary),
//             const SizedBox(width: 12),
//             Text(label, style: TextStyle(color: textPrimary, fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }

//   void _activateSearch() {
//     setState(() {
//       _isSearchActive = true;
//     });
//     _searchAnimationController.forward();
//     _loadSearchSuggestions();
//   }

//   void _deactivateSearch() {
//     _searchFocusNode.unfocus();
//     _searchAnimationController.reverse().then((_) {
//       setState(() {
//         _isSearchActive = false;
//       });
//     });
//   }

//   Future<void> _loadSearchSuggestions() async {
//     // TODO: Replace with actual API call
//     await Future.delayed(const Duration(milliseconds: 500));
//     setState(() {
//       _searchSuggestions = [
//         'Fresh Fruits',
//         'Organic Vegetables',
//         'Dairy Products',
//         'Bakery Items',
//       ];
//     });
//   }

//   Widget _buildSearchBar() {
//     return CustomSearchBar(
//       onSearchTap: () {
//         Navigator.pushNamed(context, AppRoutes.search);
//       },
//       onSearchChanged: (value) {
//         _loadSearchSuggestions();
//       },
//       searchSuggestions: _searchSuggestions,
//       isLoading: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightBackground,
//       body: Stack(
//         children: [
//           SafeArea(
//             child: CustomScrollView(
//               slivers: [
//                 // Header with Location
//                 SliverToBoxAdapter(
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     color: lightBackground,
//                     child: Column(
//                       children: [
//                         Container(
//                           color: cardBackground,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const DeliveryHeader(),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.05),
//                                       blurRadius: 4,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.notifications_outlined,
//                                       color: textPrimary,
//                                     ),
//                                     const SizedBox(width: 16),
//                                     IconButton(
//                                       icon: Icon(
//                                         Icons.shopping_cart_outlined,
//                                         color: textPrimary,
//                                       ),
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const CartPage(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         // Divider Line
//                         Container(
//                           height: 1,
//                           color: royalGreen.withOpacity(0.3),
//                         ),
//                         const SizedBox(height: 16),
//                         // Search Bar
//                         _buildSearchBar(),
//                         // Add Featured Section here
//                         const SizedBox(height: 16),
//                         _buildFeaturedSection(),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Tab Bar
//                 SliverToBoxAdapter(
//                   child: Container(
//                     height: 48,
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: cardBackground,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       itemCount: tabCategories.length,
//                       itemBuilder: (context, index) {
//                         final isSelected = _selectedTabIndex == index;
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedTabIndex = index;
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 200),
//                             curve: Curves.easeInOut,
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 4, vertical: 4),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               color: isSelected
//                                   ? tabCategories[index]['color']
//                                       .withOpacity(0.1)
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(
//                                 color: isSelected
//                                     ? tabCategories[index]['color']
//                                         .withOpacity(0.3)
//                                     : Colors.transparent,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   tabCategories[index]['icon'],
//                                   color: isSelected
//                                       ? tabCategories[index]['color']
//                                       : textSecondary,
//                                   size: 20,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   tabCategories[index]['name'],
//                                   style: TextStyle(
//                                     color: isSelected
//                                         ? tabCategories[index]['color']
//                                         : textSecondary,
//                                     fontWeight: isSelected
//                                         ? FontWeight.w600
//                                         : FontWeight.normal,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),

//                 // Product Grid
//                 SliverPadding(
//                   padding: const EdgeInsets.all(12),
//                   sliver: SliverGrid(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         final product =
//                             tabCategories[_selectedTabIndex]['products'][index];
//                         return _buildProductCard(product);
//                       },
//                       childCount:
//                           tabCategories[_selectedTabIndex]['products'].length,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Search Overlay
//           if (_isSearchActive)
//             AnimatedBuilder(
//               animation: _searchAnimation,
//               builder: (context, child) {
//                 return Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   child: Transform.translate(
//                     offset: Offset(0, -100 * (1 - _searchAnimation.value)),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       color: lightBackground,
//                       child: SafeArea(
//                         child: Column(
//                           children: [
//                             // Search Header
//                             Container(
//                               padding: const EdgeInsets.all(16),
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.arrow_back),
//                                     onPressed: _deactivateSearch,
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: searchBarBackground,
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                           color: royalGreen.withOpacity(0.3),
//                                         ),
//                                       ),
//                                       child: TextField(
//                                         controller: _searchController,
//                                         focusNode: _searchFocusNode,
//                                         autofocus: true,
//                                         style: TextStyle(
//                                           color: textPrimary,
//                                           fontSize: 16,
//                                         ),
//                                         decoration: InputDecoration(
//                                           hintText: 'Search products...',
//                                           hintStyle: TextStyle(
//                                             color: textSecondary,
//                                             fontSize: 16,
//                                           ),
//                                           border: InputBorder.none,
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                             horizontal: 16,
//                                             vertical: 12,
//                                           ),
//                                           suffixIcon: Icon(
//                                             Icons.search,
//                                             color: royalGreen,
//                                           ),
//                                         ),
//                                         onChanged: (value) {
//                                           _loadSearchSuggestions();
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Search Suggestions
//                             if (_searchSuggestions.isNotEmpty)
//                               Expanded(
//                                 child: Container(
//                                   color: cardBackground,
//                                   child: ListView.builder(
//                                     itemCount: _searchSuggestions.length,
//                                     itemBuilder: (context, index) {
//                                       return ListTile(
//                                         leading: Icon(
//                                           Icons.search,
//                                           color: textSecondary,
//                                         ),
//                                         title: Text(
//                                           _searchSuggestions[index],
//                                           style: TextStyle(
//                                             color: textPrimary,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           _searchController.text =
//                                               _searchSuggestions[index];
//                                           _deactivateSearch();
//                                           // TODO: Navigate to search results
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           if (_showPopupMenu) _buildPopupMenu(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: 65,
//         decoration: BoxDecoration(
//           color: cardBackground,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(Icons.home, 'Home', 0),
//             _buildNavItem(Icons.category, 'Categories', 1),
//             _buildCentralButton(),
//             _buildNavItem(Icons.restart_alt, 'Buy Again', 2),
//             _buildNavItem(Icons.person, 'Profile', 3),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, int index) {
//     final isSelected = _selectedTabIndex == index;
//     return GestureDetector(
//       onTap: () async {
//         setState(() {
//           _selectedTabIndex = index;
//           _showPopupMenu = false;
//           _popupController.reverse();
//         });

//         // Add navigation to profile or login page when profile is clicked
//         if (label == 'Profile') {
//           final authState = ref.read(authProvider);
//           print("Checking the AuthState of the user and validating the token");
//           if (authState.user != null) {
//             if (mounted) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ProfilePage()),
//               );
//             }
//           } else {
//             print("User is not logged in, pushing to login page");
//             if (mounted) {
//               Navigator.pushNamed(context, AppRoutes.login);
//             }
//           }
//         }
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             color: isSelected
//                 ? tabCategories[_selectedTabIndex]['color']
//                 : textSecondary,
//             size: 24,
//           ),
//           const SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected
//                   ? tabCategories[_selectedTabIndex]['color']
//                   : textSecondary,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCentralButton() {
//     return GestureDetector(
//       onTap: _togglePopupMenu,
//       child: Container(
//         width: 60,
//         height: 60,
//         margin: const EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(
//           color: tabCategories[_selectedTabIndex]['color'],
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: tabCategories[_selectedTabIndex]['color'].withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(
//           _showPopupMenu ? Icons.close : Icons.add,
//           color: Colors.white,
//           size: 32,
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard(Map<String, dynamic> product) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           AppRoutes.productListing,
//           arguments: {'category': product['name']},
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: cardBackground,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: product['color'].withOpacity(0.3)),
//           boxShadow: [
//             BoxShadow(
//               color: product['color'].withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: Image.asset(
//                     product['images'][0],
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: product['color'].withOpacity(0.1),
//                         child: Icon(
//                           product['icon'],
//                           color: product['color'],
//                           size: 32,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     product['name'],
//                     style: TextStyle(
//                       color: textPrimary,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.star, size: 12, color: product['color']),
//                       const SizedBox(width: 4),
//                       Text(
//                         '4.5',
//                         style: TextStyle(color: textSecondary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeaturedSection() {
//     if (_featuredProducts.isEmpty) {
//       return const SizedBox.shrink(); // Hide if no featured products
//     }

//     return SizedBox(
//       height: 150,
//       child: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: _featuredPageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   // Animate the previous dot back to normal size
//                   _dotControllers[_currentFeaturedIndex].reverse();
//                   _currentFeaturedIndex = index;
//                   // Animate the new dot to expanded size
//                   _dotControllers[index].forward();
//                 });
//               },
//               itemCount: _featuredProducts.length,
//               itemBuilder: (context, index) {
//                 final product = _featuredProducts[index];
//                 return Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         product['color'],
//                         product['color'].withOpacity(0.8),
//                       ],
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.asset(
//                           product['image'],
//                           width: double.infinity,
//                           height: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               color: product['color'].withOpacity(0.1),
//                               child: const Icon(
//                                 Icons.image,
//                                 color: Colors.white,
//                                 size: 32,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           gradient: const LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [Colors.black54, Colors.transparent],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               product['title'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               product['subtitle'],
//                               style: TextStyle(
//                                 color: Colors.white.withOpacity(0.9),
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 8),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 _featuredProducts.length,
//                 (index) => AnimatedBuilder(
//                   animation: _dotAnimations[index],
//                   builder: (context, child) {
//                     return Container(
//                       width: 6 * _dotAnimations[index].value,
//                       height: 6 * _dotAnimations[index].value,
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey.withOpacity(
//                           _currentFeaturedIndex == index ? 0.8 : 0.3,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CurvedConnectorPainter extends CustomPainter {
//   final Color color;

//   CurvedConnectorPainter({required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final path = Path()
//       ..moveTo(size.width / 2, 0)
//       ..quadraticBezierTo(
//         size.width / 2,
//         size.height * 0.7,
//         size.width / 2,
//         size.height,
//       );

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CurvedConnectorPainter oldDelegate) {
//     return color != oldDelegate.color;
//   }
// }
