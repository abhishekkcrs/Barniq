// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sizzle/commons/widgets/custom_search_bar.dart';
// import 'package:sizzle/providers/auth_provider.dart';
// import 'package:sizzle/utils/loadUser.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../commons/widgets/delivery_header.dart';
// import 'daily_needs.dart';
// import 'order_again_page.dart';
// import 'cart_page.dart';
// import 'category_products.dart';
// import 'profile_page.dart';
// import '../entities/UserDetails.dart';
// import '../entities/productmin.dart';

// // class Product {
// //   final String title;
// //   final IconData icon;
// //   final Color color;
// //   final double price;
// //   final double discount;

// //   Product({
// //     required this.title,
// //     required this.icon,
// //     required this.color,
// //     required this.price,
// //     required this.discount,
// //   });
// // }

// class CompactProductCard extends StatelessWidget {
//   final ProductMin product;
//   final bool isSmallScreen;

//   const CompactProductCard({
//     Key? key,
//     required this.product,
//     this.isSmallScreen = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//               ),
//               child: Center(
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Icon(
//                     Icons.image,
//                     color: Colors.grey[400],
//                     size: isSmallScreen ? 24 : 28,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: EdgeInsets.all(isSmallScreen ? 4.0 : 6.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     product.name,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: isSmallScreen ? 10 : 11,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '₹${product.price}',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: isSmallScreen ? 10 : 11,
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: isSmallScreen ? 4 : 6,
//                           vertical: isSmallScreen ? 1 : 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         child: Text(
//                           '${product.discountPercentage.toStringAsFixed(0)}%',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontWeight: FontWeight.bold,
//                             fontSize: isSmallScreen ? 8 : 9,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final ProductMin product;
//   final bool isHorizontal;
//   final double? width;
//   final double? height;
//   final bool isSmallScreen;

//   const ProductCard({
//     Key? key,
//     required this.product,
//     this.isHorizontal = false,
//     this.width,
//     this.height,
//     this.isSmallScreen = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//               ),
//               child: Center(
//                 child: Image.network(
//                   product.imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Icon(
//                     Icons.image,
//                     color: Colors.grey[400],
//                     size: isHorizontal
//                         ? (isSmallScreen ? 24 : 32)
//                         : (isSmallScreen ? 36 : 48),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(isHorizontal
//                 ? (isSmallScreen ? 4.0 : 6.0)
//                 : (isSmallScreen ? 8.0 : 12.0)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: isHorizontal
//                         ? (isSmallScreen ? 10 : 11)
//                         : (isSmallScreen ? 12 : 14),
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(
//                     height: isHorizontal
//                         ? (isSmallScreen ? 2 : 4)
//                         : (isSmallScreen ? 6 : 8)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '₹${product.price}',
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: isHorizontal
//                             ? (isSmallScreen ? 10 : 12)
//                             : (isSmallScreen ? 14 : 16),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: isSmallScreen ? 6 : 8,
//                         vertical: isSmallScreen ? 2 : 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         '${product.discountPercentage.toStringAsFixed(0)}% OFF',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                           fontSize: isHorizontal
//                               ? (isSmallScreen ? 8 : 10)
//                               : (isSmallScreen ? 10 : 12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final List<Map<String, String>> categories = [
//     {
//       'label': 'Dal & Pulses',
//       'image': 'https://picsum.photos/200/200?random=1',
//     },
//     {
//       'label': 'Oil & Ghee',
//       'image': 'https://picsum.photos/200/200?random=2',
//     },
//     {
//       'label': 'Atta',
//       'image': 'https://picsum.photos/200/200?random=3',
//     },
//     {
//       'label': 'Masala & Spices',
//       'image': 'https://picsum.photos/200/200?random=4',
//     },
//     {
//       'label': 'Dry Fruits, Nuts & Seeds',
//       'image': 'https://picsum.photos/200/200?random=5',
//     },
//     {
//       'label': 'Salt & Sugar',
//       'image': 'https://picsum.photos/200/200?random=6',
//     },
//     {
//       'label': 'Cookies',
//       'image': 'https://picsum.photos/200/200?random=7',
//     },
//     {
//       'label': 'Chips',
//       'image': 'https://picsum.photos/200/200?random=8',
//     },
//     {
//       'label': 'Juices & Fruit Drinks',
//       'image': 'https://picsum.photos/200/200?random=9',
//     },
//     {
//       'label': 'Soft Drinks',
//       'image': 'https://picsum.photos/200/200?random=10',
//     },
//     {
//       'label': 'Noodles',
//       'image': 'https://picsum.photos/200/200?random=11',
//     },
//     {
//       'label': 'Detergents & Laundry',
//       'image': 'https://picsum.photos/200/200?random=12',
//     },
//     {
//       'label': 'Chocolates & Sweets',
//       'image': 'https://picsum.photos/200/200?random=13',
//     },
//     {
//       'label': 'Body wash & Soaps',
//       'image': 'https://picsum.photos/200/200?random=14',
//     },
//     {
//       'label': 'Hair Care',
//       'image': 'https://picsum.photos/200/200?random=15',
//     },
//     {
//       'label': 'Oral Care',
//       'image': 'https://picsum.photos/200/200?random=16',
//     },
//   ];

//   int selectedMenuIndex = 0;
//   final ScrollController _scrollController = ScrollController();
//   bool _isHeaderVisible = true;
//   double _lastScrollPosition = 0;

//   UserDetails? user;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     try {
//       final result = await loadUserFromSecureStorage();
//       if (mounted) {
//         setState(() {
//           user = result;
//         });
//       }
//     } catch (e) {
//       print('Error loading user: $e');
//       // Handle error appropriately
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final currentScroll = _scrollController.position.pixels;
//     if (currentScroll > _lastScrollPosition && currentScroll > 0) {
//       // Scrolling down
//       if (_isHeaderVisible) {
//         setState(() => _isHeaderVisible = false);
//       }
//     } else if (currentScroll < _lastScrollPosition) {
//       // Scrolling up
//       if (!_isHeaderVisible) {
//         setState(() => _isHeaderVisible = true);
//       }
//     }
//     _lastScrollPosition = currentScroll;
//   }

//   List<ProductMin> getMockProducts(String section) {
//     return List.generate(
//       12,
//       (i) => ProductMin(
//         id: i,
//         name: 'Product ${i + 1}',
//         price: (i + 1) * 99,
//         discountPercentage: (i + 1) * 5.0,
//         imageUrl: 'https://picsum.photos/200/200?random=${i + 1}',
//         ratingsCount: (i + 1) * 10,
//         rating: (i + 1) * 0.5,
//       ),
//     );
//   }

//   void _showCategories(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(
//                   'All Categories',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   itemCount: categories.length,
//                   separatorBuilder: (context, i) => Divider(height: 1),
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           categories[index]['image']!,
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(categories[index]['label']!),
//                       onTap: () {},
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isSmallScreen = size.width < 360;
//     final isMediumScreen = size.width >= 360 && size.width < 600;
//     final isLargeScreen = size.width >= 600;

//     // Calculate responsive values
//     final double appBarHeight = isSmallScreen ? 80 : 90;
//     final double avatarRadius = isSmallScreen ? 20 : 24;
//     final double iconSize = isSmallScreen ? 24 : 28;
//     final double horizontalPadding = isSmallScreen ? 12.0 : 16.0;
//     final double gridSpacing = isSmallScreen ? 8.0 : 12.0;
//     final int gridCrossAxisCount = isSmallScreen ? 3 : (isMediumScreen ? 4 : 5);

//     final List<Map<String, String>> visibleCategories = categories
//         .where((cat) => cat['image'] != null && cat['image']!.isNotEmpty)
//         .toList();

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: NestedScrollView(
//         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//           SliverAppBar(
//             backgroundColor: const Color.fromARGB(255, 244, 228, 175),
//             elevation: 0,
//             toolbarHeight: appBarHeight,
//             floating: true,
//             snap: true,
//             pinned: true,
//             forceElevated: innerBoxIsScrolled,
//             titleSpacing: 0,
//             title: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: isSmallScreen ? 8.0 : 12.0,
//                       right: isSmallScreen ? 6.0 : 8.0,
//                     ),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProfilePage(),
//                           ),
//                         );
//                       },
//                       child: CircleAvatar(
//                         backgroundImage: user?.photoUrl != null
//                             ? NetworkImage(user!.photoUrl!)
//                             : const NetworkImage(
//                                 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
//                         radius: avatarRadius,
//                       ),
//                     ),
//                   ),
//                   Expanded(child: DeliveryHeader()),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       right: isSmallScreen ? 12.0 : 16.0,
//                       left: isSmallScreen ? 6.0 : 8.0,
//                     ),
//                     child: Icon(
//                       Icons.notifications_none,
//                       color: Colors.brown,
//                       size: iconSize,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Fixed Search Bar and Menu
//           SliverPersistentHeader(
//             pinned: true,
//             delegate: _SliverAppBarDelegate(
//               Container(
//                 color: const Color.fromARGB(255, 244, 228, 175),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: horizontalPadding),
//                       child: CustomSearchBar(
//                         onSearchTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => SearchPage(
//                                 suggestions: [
//                                   'Apple',
//                                   'Banana',
//                                   'Milk',
//                                   'Bread',
//                                   'Eggs',
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         onSearchChanged: (query) {
//                           // Handle search query change
//                         },
//                         searchSuggestions: [
//                           'Apple',
//                           'Banana',
//                           'Milk',
//                           'Bread',
//                           'Eggs',
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: isSmallScreen ? 4 : 8),
//                     Container(
//                       width: double.infinity,
//                       margin: EdgeInsets.symmetric(vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       child: SizedBox(
//                         height: isSmallScreen ? 56 : 64,
//                         child: ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             _iconMenuItem(
//                               Icons.shopping_bag_outlined,
//                               "All",
//                               0,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.checkroom,
//                               "Fashion",
//                               1,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.brush,
//                               "Beauty",
//                               2,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.local_hospital_outlined,
//                               "Pharmacy",
//                               3,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.local_grocery_store_outlined,
//                               "Fresh",
//                               4,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.headphones,
//                               "Electronics",
//                               5,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.cleaning_services,
//                               "Home",
//                               6,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.percent,
//                               "80% Off",
//                               7,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                             _iconMenuItem(
//                               Icons.local_cafe_outlined,
//                               "Cafe",
//                               8,
//                               isSmallScreen: isSmallScreen,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xFFFFF8E1), Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
//             ),
//           ),
//           child: CustomScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     // HEADER GOLDEN BACKGROUND START
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(24),
//                           bottomRight: Radius.circular(24),
//                         ),
//                       ),
//                       padding: EdgeInsets.only(bottom: 8),
//                       child: Column(children: [SizedBox(height: 2)]),
//                     ),
//                     // HEADER GOLDEN BACKGROUND END
//                     SizedBox(height: 12),
//                     // Promotional Banner
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.pink[50],
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Center(
//                             child: Text(
//                               "CELEBRATE\nMother's Day",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 24,
//                                 color: Colors.pink[800],
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           GridView.count(
//                             crossAxisCount: 3,
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             mainAxisSpacing: 12,
//                             crossAxisSpacing: 12,
//                             children: [
//                               _promoCard(
//                                 "Mother's Day Specials",
//                                 Icons.coffee,
//                                 Colors.orange,
//                               ),
//                               _promoCard(
//                                 "Cards, Flowers & More",
//                                 Icons.local_florist,
//                                 Colors.red,
//                               ),
//                               _promoCard(
//                                 "Gift A Gadget",
//                                 Icons.coffee_maker,
//                                 Colors.brown,
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 12),
//                           Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(vertical: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.pink[100],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Give your mom an award she really deserves",
//                                 style: TextStyle(
//                                   color: Colors.pink[900],
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     // Deals Starting at ₹29 (with categories bar and product images)
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Color(0xFF2176FF),
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       margin: EdgeInsets.only(bottom: 16),
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 _categoryChip('Toys'),
//                                 _categoryChip('Electronics'),
//                                 _categoryChip('Home Needs'),
//                                 _categoryChip('Fashion'),
//                                 _categoryChip('Kitchen'),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'deals starting at',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     Text(
//                                       '₹29',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 40,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     ElevatedButton(
//                                       onPressed: () {},
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.brown,
//                                         foregroundColor: Colors.white,
//                                         shape: StadiumBorder(),
//                                       ),
//                                       child: Text('See inside'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Row(
//                                 children: [
//                                   _dealImage(
//                                     'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
//                                     48,
//                                   ), // Blender
//                                   _dealImage(
//                                     'https://cdn-icons-png.flaticon.com/512/3075/3075978.png',
//                                     48,
//                                   ), // Shoes
//                                   _dealImage(
//                                     'https://cdn-icons-png.flaticon.com/512/3075/3075979.png',
//                                     48,
//                                   ), // Teddy
//                                   _dealImage(
//                                     'https://cdn-icons-png.flaticon.com/512/3075/3075980.png',
//                                     48,
//                                   ), // Lamp
//                                   _dealImage(
//                                     'https://cdn-icons-png.flaticon.com/512/3075/3075981.png',
//                                     48,
//                                   ), // Watch
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Free Delivery Info Bar
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 16,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.yellow[100],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.yellow),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.lock, color: Colors.yellow[900]),
//                           SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               "Add items worth ₹99 to unlock free delivery with pass",
//                               style: TextStyle(
//                                 color: Colors.yellow[900],
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Convert grid sections to slivers
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Shop by category',
//                   Color(0xFFE3F2FD),
//                   getMockProducts('Shop by category'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Limited Time Deals',
//                   Color(0xFFFFFDE7),
//                   getMockProducts('Limited Time Deals'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Hot Picks in Demand',
//                   Color(0xFFF1F8E9),
//                   getMockProducts('Hot Picks in Demand'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Lowest Price and Free',
//                   Color(0xFFFFF8F6),
//                   getMockProducts('Lowest Price and Free'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Deals of the Day',
//                   Color(0xFFE3F2FD),
//                   getMockProducts('Deals of the Day'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'New Launches',
//                   Color(0xFFF8EAF6),
//                   getMockProducts('New Launches'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Lowest Price',
//                   Color(0xFFFFF8E1),
//                   getMockProducts('Lowest Price'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: _buildGridSection(
//                   context,
//                   'Maximize Savings',
//                   Color(0xFFE0F7FA),
//                   getMockProducts('Maximize Savings'),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: superSummerSavingsPoster(),
//               ),
//               // Add padding at the bottom for the floating cart button
//               SliverToBoxAdapter(
//                 child: SizedBox(height: 80),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Color(0xFFFFF8E1),
//         selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.brown.withOpacity(0.7),
//         selectedFontSize: isSmallScreen ? 10 : 12,
//         unselectedFontSize: isSmallScreen ? 10 : 12,
//         iconSize: isSmallScreen ? 20 : 24,
//         onTap: (index) {
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     DailyNeedsPage(categories: visibleCategories),
//               ),
//             );
//           } else if (index == 3) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OrderAgainPage()),
//             );
//           } else if (index == 4) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CartPage()),
//             );
//           }
//         },
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Barniq'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star_border),
//             label: 'Daily Needs',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.replay),
//             label: 'Order Again',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_basket_outlined),
//             label: 'Basket',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _promoCard(String label, IconData icon, Color color) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.black12),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: color, size: 32),
//           SizedBox(height: 8),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(
//     BuildContext context,
//     String title,
//     Color bgColor,
//   ) {
//     final isSmallScreen = MediaQuery.of(context).size.width < 360;
//     return Container(
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: isSmallScreen ? 8 : 12,
//         vertical: isSmallScreen ? 4 : 6,
//       ),
//       margin: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: isSmallScreen ? 16 : 18,
//               color: Colors.black87,
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductListPage(
//                     sectionTitle: title,
//                     products: getMockProducts(title),
//                   ),
//                 ),
//               );
//             },
//             child: Text(
//               "View All",
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: isSmallScreen ? 12 : 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGridSection(
//     BuildContext context,
//     String title,
//     Color bgColor,
//     List<ProductMin> products,
//   ) {
//     final size = MediaQuery.of(context).size;
//     final isSmallScreen = size.width < 360;
//     final isMediumScreen = size.width >= 360 && size.width < 600;

//     final scrollHeight = isSmallScreen ? 110.0 : 130.0;

//     final firstRowCount = products.length >= 3 ? 3 : products.length;
//     final secondRowCount = products.length > 3 ? products.length - 3 : 0;

//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 4 : 6),
//       padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
//       decoration: BoxDecoration(
//         color: bgColor,
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionHeader(context, title, bgColor),
//           SizedBox(height: isSmallScreen ? 6 : 8),

//           // First row: GridView with compact cards
//           if (firstRowCount > 0)
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: EdgeInsets.symmetric(
//                 horizontal: isSmallScreen ? 2 : 4,
//                 vertical: isSmallScreen ? 2 : 4,
//               ),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: isSmallScreen ? 4 : 8,
//                 crossAxisSpacing: isSmallScreen ? 4 : 8,
//                 childAspectRatio:
//                     isSmallScreen ? 0.6 : (isMediumScreen ? 0.65 : 0.7),
//               ),
//               itemCount: firstRowCount,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return CompactProductCard(
//                   product: product,
//                   isSmallScreen: isSmallScreen,
//                 );
//               },
//             ),

//           // Second row: Horizontally scrollable with regular cards
//           if (secondRowCount > 0) ...[
//             SizedBox(height: isSmallScreen ? 8 : 10),
//             SizedBox(
//               height: scrollHeight,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: secondRowCount,
//                 itemBuilder: (context, idx) {
//                   final product = products[idx + 3];
//                   return Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: isSmallScreen ? 6.0 : 8.0,
//                       vertical: isSmallScreen ? 2.0 : 4.0,
//                     ),
//                     child: SizedBox(
//                       width: isSmallScreen ? 140 : 160,
//                       child: ProductCard(
//                         product: product,
//                         height: isSmallScreen ? 100 : 120,
//                         isHorizontal: true,
//                         isSmallScreen: isSmallScreen,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _categoryChip(String label) {
//     return Container(
//       margin: EdgeInsets.only(right: 8),
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _dealImage(String url, double size) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 2.0),
//       child: Image.network(url, width: size, height: size),
//     );
//   }

//   Widget _hotPickCard(String label, String imageUrl) {
//     return Container(
//       width: 140,
//       margin: EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: Color(0xFF6B3F1D),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 12),
//             decoration: BoxDecoration(
//               color: Color(0xFFFFD600),
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             padding: EdgeInsets.all(8),
//             child: Image.network(
//               imageUrl,
//               width: 60,
//               height: 60,
//               fit: BoxFit.contain,
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget superSummerSavingsPoster() {
//     final isSmallScreen = MediaQuery.of(context).size.width < 360;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: isSmallScreen ? 8 : 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         image: DecorationImage(
//           image: NetworkImage(
//             'https://picsum.photos/800/400?random=1',
//           ),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             Colors.yellow.withOpacity(0.18),
//             BlendMode.dstATop,
//           ),
//         ),
//         color: Colors.yellow[100],
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
//         ],
//       ),
//       padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Super summer savings',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: isSmallScreen ? 16 : 18,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               Icon(Icons.arrow_right_alt,
//                   color: Colors.black, size: isSmallScreen ? 24 : 28),
//             ],
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Text(
//                 'Powered by:',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: isSmallScreen ? 12 : 14,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(width: 4),
//               Image.network(
//                 'https://picsum.photos/100/30?random=2',
//                 height: isSmallScreen ? 18 : 22,
//                 errorBuilder: (context, error, stackTrace) => Container(
//                   height: isSmallScreen ? 18 : 22,
//                   color: Colors.grey[200],
//                   child: Icon(Icons.image, size: isSmallScreen ? 16 : 20),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: isSmallScreen ? 8 : 12),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _summerSavingPosterCard('Aerated drinks', [
//                   'https://picsum.photos/100/100?random=3',
//                   'https://picsum.photos/100/100?random=4',
//                 ]),
//                 _summerSavingPosterCard('Juice & Mixes', [
//                   'https://picsum.photos/100/100?random=5',
//                   'https://picsum.photos/100/100?random=6',
//                   'https://picsum.photos/100/100?random=7',
//                 ]),
//                 _summerSavingPosterCard('Body & hair Care', [
//                   'https://picsum.photos/100/100?random=8',
//                   'https://picsum.photos/100/100?random=9',
//                 ]),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summerSavingPosterCard(String label, List<String> imageUrls) {
//     final isSmallScreen = MediaQuery.of(context).size.width < 360;
//     return Container(
//       width: isSmallScreen ? 90 : 100,
//       margin: EdgeInsets.symmetric(horizontal: 4),
//       padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ...imageUrls.map(
//             (url) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 2.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Image.network(
//                   url,
//                   width: isSmallScreen ? 36 : 40,
//                   height: isSmallScreen ? 36 : 40,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     width: isSmallScreen ? 36 : 40,
//                     height: isSmallScreen ? 36 : 40,
//                     color: Colors.grey[200],
//                     child: Icon(Icons.image, size: isSmallScreen ? 20 : 24),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: isSmallScreen ? 10 : 12,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _iconMenuItem(IconData icon, String label, int index,
//       {bool isSmallScreen = false}) {
//     final isSelected = selectedMenuIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedMenuIndex = index;
//         });
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 CategoryProductsPage(categoryName: label, icon: icon),
//           ),
//         );
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8.0 : 12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               icon,
//               color: Colors.brown,
//               size: isSmallScreen ? 24 : 28,
//             ),
//             SizedBox(height: isSmallScreen ? 2 : 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.brown,
//                 fontSize: isSmallScreen ? 10 : 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: isSmallScreen ? 2 : 4),
//             Container(
//               height: 3,
//               width: isSmallScreen ? 24 : 28,
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.brown : Colors.transparent,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IconMenuItem extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const IconMenuItem({Key? key, required this.icon, required this.label})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 CategoryProductsPage(categoryName: label, icon: icon),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.brown, size: 28),
//             SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.brown,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProductListPage extends StatelessWidget {
//   final String sectionTitle;
//   final List<ProductMin> products;

//   const ProductListPage({
//     Key? key,
//     required this.sectionTitle,
//     required this.products,
//   }) : super(key: key);
// // 0xFFFFF3C1
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(sectionTitle),
//         backgroundColor: Color(0xFFFFF3C1),
//         iconTheme: IconThemeData(color: Colors.brown),
//         titleTextStyle: TextStyle(
//           color: Colors.brown,
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: Color(0xFFFFF3C1),
//       body: GridView.builder(
//         padding: EdgeInsets.all(16),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return ProductCard(product: products[index]);
//         },
//       ),
//     );
//   }
// }

// class _RocketAnimation extends StatefulWidget {
//   @override
//   State<_RocketAnimation> createState() => _RocketAnimationState();
// }

// class _RocketAnimationState extends State<_RocketAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: false);
//     _offsetAnimation = Tween<Offset>(
//       begin: Offset(0, 0.3),
//       end: Offset(0, -0.3),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _offsetAnimation,
//       child: Icon(Icons.rocket_launch, color: Colors.deepOrange, size: 28),
//     );
//   }
// }

// class SearchPage extends StatefulWidget {
//   final List<String> suggestions;
//   const SearchPage({Key? key, required this.suggestions}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   late TextEditingController _controller;
//   String _query = '';
//   List<String> recentSearches = ['pad'];

//   final List<Map<String, dynamic>> trending = [
//     {
//       'title': 'Hocco Ice Cream',
//       'images': [
//         'https://www.hocco.in/wp-content/uploads/2021/07/Choco-Chips-Ice-Cream-500x500-1.jpg',
//         'https://www.hocco.in/wp-content/uploads/2021/07/Chocolate-Ice-Cream-500x500-1.jpg',
//       ],
//     },
//     {
//       'title': 'Sunfeast Dark Fantasy Cookies',
//       'images': [
//         'https://www.bigbasket.com/media/uploads/p/m/40075410_7-britannia-good-day-cashew-cookies.jpg',
//         'https://www.bigbasket.com/media/uploads/p/m/40001687_8-catch-turmeric-powder.jpg',
//       ],
//     },
//     {
//       'title': 'Sunfeast Yippee Noodles',
//       'images': [
//         'https://www.bigbasket.com/media/uploads/p/m/40033837_8-maggi-2-minute-instant-noodles.jpg',
//       ],
//     },
//     {
//       'title': 'Snickers Chocolate',
//       'images': [
//         'https://www.bigbasket.com/media/uploads/p/m/40033839_8-cadbury-dairy-milk-chocolate.jpg',
//         'https://www.bigbasket.com/media/uploads/p/m/40033839_8-cadbury-dairy-milk-chocolate.jpg',
//       ],
//     },
//     {
//       'title': 'Hanuman',
//       'images': [
//         'https://rukminim2.flixcart.com/image/416/416/xif0q/showpiece-figurine/2/2/2/hanuman-ji-idol-for-car-dashboard-home-office-pooja-mandir-original-imagqz2h2zqzqzqz.jpeg',
//         'https://rukminim2.flixcart.com/image/416/416/xif0q/showpiece-figurine/2/2/2/hanuman-ji-idol-for-car-dashboard-home-office-pooja-mandir-original-imagqz2h2zqzqzqz.jpeg',
//       ],
//     },
//     {
//       'title': 'Wooden Stick',
//       'images': [
//         'https://5.imimg.com/data5/SELLER/Default/2022/12/ZX/GL/GL/1569826/wooden-ice-cream-stick-500x500.jpg',
//         'https://5.imimg.com/data5/SELLER/Default/2022/12/ZX/GL/GL/1569826/wooden-ice-cream-stick-500x500.jpg',
//       ],
//     },
//   ];

//   final List<Map<String, dynamic>> chipsProducts = [
//     {
//       'image':
//           'https://www.bigbasket.com/media/uploads/p/m/40033837_8-maggi-2-minute-instant-noodles.jpg',
//       'name': 'Uncle Chipps Spicy Treat Flavour Potato Chips',
//       'weight': '48 g',
//       'type': 'Potato Chips',
//       'price': 20,
//       'rating': 4.5,
//       'reviews': 121956,
//       'time': '8 MINS',
//       'bestseller': true,
//     },
//     {
//       'image':
//           'https://www.bigbasket.com/media/uploads/p/m/40000267_8-lays-potato-chips-indias-magic-masala.jpg',
//       'name': "Lay's India's Magic Masala Potato Chips",
//       'weight': '67 g',
//       'type': 'Potato Chips',
//       'price': 30,
//       'rating': 4.4,
//       'reviews': 34005,
//       'time': '8 MINS',
//       'bestseller': false,
//     },
//     {
//       'image':
//           'https://www.bigbasket.com/media/uploads/p/m/40033837_8-maggi-2-minute-instant-noodles.jpg',
//       'name': "Lay's American Style Cream & Onion Potato Chips",
//       'weight': '67 g',
//       'type': 'Potato Chips',
//       'price': 30,
//       'rating': 4.3,
//       'reviews': 23715,
//       'time': '8 MINS',
//       'bestseller': false,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_focusNode);
//     });
//   }

//   final FocusNode _focusNode = FocusNode();

//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFFFF8E1),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFFF8E1),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.brown),
//         titleSpacing: 0,
//         title: SizedBox(
//           height: 44,
//           child: Stack(
//             alignment: Alignment.centerRight,
//             children: [
//               TextField(
//                 controller: _controller,
//                 focusNode: _focusNode,
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: 'Search for atta, dal, coke and more',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 0,
//                   ),
//                 ),
//                 onChanged: (val) => setState(() {}),
//                 onSubmitted: (val) {
//                   if (val.isNotEmpty && !recentSearches.contains(val)) {
//                     setState(() {
//                       recentSearches.insert(0, val);
//                     });
//                   }
//                 },
//               ),
//               Positioned(
//                 right: 8,
//                 child: IconButton(
//                   icon: Icon(Icons.mic, color: Colors.brown),
//                   onPressed: () {
//                     // Handle record/mic action
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         children: [
//           // Recent Searches
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Recent searches',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//               if (recentSearches.isNotEmpty)
//                 GestureDetector(
//                   onTap: () => setState(() => recentSearches.clear()),
//                   child: Text(
//                     'clear',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(height: 8),
//           if (recentSearches.isEmpty)
//             Text('No recent searches', style: TextStyle(color: Colors.grey)),
//           if (recentSearches.isNotEmpty)
//             Wrap(
//               spacing: 8,
//               children: recentSearches
//                   .map(
//                     (s) => Chip(
//                       label: Text(s),
//                       onDeleted: () => setState(() => recentSearches.remove(s)),
//                     ),
//                   )
//                   .toList(),
//             ),
//           SizedBox(height: 18),
//           // Trending in your city
//           Text(
//             'Trending in your city',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(height: 10),
//           SizedBox(
//             height: 110,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: trending.length,
//               separatorBuilder: (_, __) => SizedBox(width: 10),
//               itemBuilder: (context, i) {
//                 final t = trending[i];
//                 return Container(
//                   width: 140,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFB2DFDB),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         t['title'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 13,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Row(
//                         children: List.generate(
//                           t['images'].length,
//                           (j) => Padding(
//                             padding: const EdgeInsets.only(right: 4.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(6),
//                               child: Image.network(
//                                 t['images'][j],
//                                 width: 36,
//                                 height: 36,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 18),
//           // Chips & Crisps
//           Text(
//             'Chips & Crisps',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(height: 10),
//           SizedBox(
//             height: 240,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: chipsProducts.length,
//               separatorBuilder: (_, __) => SizedBox(width: 12),
//               itemBuilder: (context, i) {
//                 final p = chipsProducts[i];
//                 return Container(
//                   width: 160,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (p['bestseller'])
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.yellow[700],
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             'Bestseller',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       SizedBox(height: 4),
//                       Center(
//                         child: Image.network(
//                           p['image'],
//                           width: 70,
//                           height: 70,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '${p['weight']}  ${p['type']}',
//                         style: TextStyle(fontSize: 11, color: Colors.grey[700]),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         p['name'],
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 13,
//                           height: 1.2,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.amber, size: 14),
//                           SizedBox(width: 2),
//                           Text(
//                             '${p['rating']}',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             '(${p['reviews']})',
//                             style: TextStyle(fontSize: 11, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         '${p['time']}',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.green[700],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         '₹${p['price']}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: Colors.green[900],
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.green,
//                             side: BorderSide(color: Colors.green),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             padding: EdgeInsets.symmetric(vertical: 6),
//                           ),
//                           child: Text(
//                             'ADD',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: TextButton(
//               onPressed: () {},
//               child: Text('See all products'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;

//   _SliverAppBarDelegate(this.child);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   double get maxExtent => 140.0;

//   @override
//   double get minExtent => 140.0;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
