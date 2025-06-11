import 'package:flutter/material.dart';
import '../commons/widgets/custom_card.dart';
import '../commons/widgets/recommended_products_card.dart';
import 'product_detail_page.dart';
import '../entities/product.dart';
import '../entities/grocery_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Example cart items for delivery section
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Thums Up Soft Drink (750 ml)',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
      'quantity': 1,
      'price': 40.0,
      'desc': '750 ml',
    },
    {
      'name': 'Thums Up cold Drink (750 ml)',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
      'quantity': 1,
      'price': 40.0,
      'desc': '750 ml',
    },
  ];

  // Special deals items
  final List<Map<String, dynamic>> specialDeals = [
    {
      'name': 'Free Soft Drink Bottle',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
      'desc': 'FREE',
      'options': 2,
    },
    {
      'name': 'Fresh Mangoes',
      'image':
          'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?w=500',
      'desc': '₹99',
      'options': 1,
    },
  ];

  // Recommended items
  final List<GroceryProduct> recommendedItems = [
    GroceryProduct(
      title: "Lay's India's Magic Masala Potato Chips",
      icon: Icons.shopping_bag,
      color: Colors.orange,
      price: 20,
      discount: 0,
      image:
          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500',
      weight: '48 g',
      tag: 'Magic Masala',
      rating: 4.5,
      reviews: 96340,
    ),
    GroceryProduct(
      title: 'Cadbury Perk Plus Coated Wafer Chocolate Bar',
      icon: Icons.shopping_bag,
      color: Colors.brown,
      price: 55,
      discount: 8,
      image:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500',
      weight: '3 x 40 g',
      mrp: 60,
      rating: 4.2,
      reviews: 1711,
    ),
    GroceryProduct(
      title: 'Kurkure Masala Munch Crisps',
      icon: Icons.shopping_bag,
      color: Colors.orange,
      price: 20,
      discount: 0,
      image:
          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500',
      weight: '75 g',
      tag: 'Corn Crisps',
      rating: 4.3,
      reviews: 111786,
    ),
    GroceryProduct(
      title: 'Ice Cubes by Dras Ice',
      icon: Icons.shopping_bag,
      color: Colors.blue,
      price: 75,
      discount: 0,
      image:
          'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?w=500',
      weight: '1 kg',
      rating: 4.4,
      reviews: 10939,
    ),
    GroceryProduct(
      title: 'Maggi Masala - 2 Minutes Instant Noodles',
      icon: Icons.shopping_bag,
      color: Colors.orange,
      price: 60,
      discount: 0,
      image:
          'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=500',
      weight: '280 g',
      rating: 4.6,
      reviews: 95396,
    ),
    GroceryProduct(
      title: 'Act II Butter Popcorn - Ready to Eat',
      icon: Icons.shopping_bag,
      color: Colors.yellow,
      price: 25,
      discount: 0,
      image:
          'https://images.unsplash.com/photo-1625944525903-bb1d7a9267de?w=500',
      weight: '47 g',
      tag: 'Popcorn',
      rating: 4.7,
      reviews: 36863,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                floating: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Checkout',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xFF1B5E20),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Share',
                          style: TextStyle(
                            color: Color(0xFF1B5E20),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 130),
                  child: Column(
                    children: [
                      // Special Deals Section
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Special deals for you!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 180,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: specialDeals.length,
                                separatorBuilder: (context, i) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, i) {
                                  final deal = specialDeals[i];
                                  return Container(
                                    width: 320,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF7F8FA),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFE0E0E0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  deal['image'],
                                                  width: 56,
                                                  height: 56,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      deal['name'],
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      deal['desc'],
                                                      style: const TextStyle(
                                                        color: Color(
                                                          0xFF1B5E20,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  OutlinedButton(
                                                    style: OutlinedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                        color: Color(
                                                          0xFF1B5E20,
                                                        ),
                                                      ),
                                                      minimumSize: const Size(
                                                        50,
                                                        28,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8,
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      'VIEW',
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF1B5E20,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFD1C4E9),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    '₹40',
                                                    style: TextStyle(
                                                      color: Color(0xFF7E57C2),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: 40 /
                                                          299, // 40 is current amount, 299 is target (259 + 40)
                                                      backgroundColor: Colors
                                                          .white
                                                          .withOpacity(0.3),
                                                      valueColor:
                                                          const AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Color(
                                                                  0xFF7E57C2)),
                                                      minHeight: 4,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    '₹299',
                                                    style: TextStyle(
                                                      color: Color(0xFF7E57C2),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.lock,
                                                    color: Color(0xFF7E57C2),
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'Add items worth ₹259 more to unlock the offer.',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .deepPurple[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Delivery Section
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Color(0xFF1B5E20),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Delivery in 8 minutes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Shipment of 1 item',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...cartItems.asMap().entries.map((entry) {
                              final i = entry.key;
                              final item = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item['image'],
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            item['desc'],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(0, 0),
                                            ),
                                            child: const Text(
                                              'Save for later',
                                              style: TextStyle(
                                                color: Color(0xFF1B5E20),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F8E9),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 18,
                                              color: Color(0xFF1B5E20),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (cartItems[i]['quantity'] >
                                                    1) {
                                                  cartItems[i]['quantity']--;
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            '${item['quantity']}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 18,
                                              color: Color(0xFF1B5E20),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                cartItems[i]['quantity']++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '₹${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      // You Might Also Like Section
                      RecommendedProductsCard(
                        recommendedItems: recommendedItems,
                      ),
                      // Make this a gift
                      CustomCard(
                        backgroundColor: const Color(0xFFFFF8E1),
                        hasShadow: false,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3534/3534066.png',
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Make this a gift!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Get your items in a special gift bag for just ₹30',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF1B5E20),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Select',
                                style: TextStyle(
                                  color: Color(0xFF1B5E20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Get FREE delivery
                      CustomCard(
                        backgroundColor: const Color(0xFFE3F2FD),
                        hasShadow: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.local_shipping,
                                  color: Color(0xFF1976D2),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Get FREE delivery',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: const [
                                Text(
                                  'Add products worth ₹59 more',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Color(0xFFBBDEFB),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF1976D2),
                              ),
                              minHeight: 6,
                            ),
                          ],
                        ),
                      ),
                      // See all coupons
                      CustomCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'See all coupons',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      // Bill details
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bill details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Items total'),
                                Text('₹40'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Handling charge'),
                                Text('₹2'),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Delivery charge'),
                                    Text(
                                      'Shop for ₹59 more to get FREE delivery',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('₹25'),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Grand total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '₹67',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add GSTIN
                      CustomCard(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Add GSTIN\nClaim GST input credit up to 28% on your order',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Donate to Feeding India
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Donate to Feeding India ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 16,
                                  color: Colors.grey[700],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Your continued support will help us serve daily meals to children',
                              style: TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://static.toiimg.com/thumb/msid-78935725,width-400,resizemode-4/78935725.jpg',
                                    width: 60,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text('Donation amount'),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F8E9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '₹5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF1B5E20),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    minimumSize: const Size(40, 32),
                                  ),
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Color(0xFF1B5E20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Tip your delivery partner
                      CustomCard(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3079/3079187.png',
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Tip your delivery partner',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Your kindness means a lot! 100% of your tip will go directly to your delivery partner.',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Footer
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Total Amount',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '₹67',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF7F8FA),
                          foregroundColor: const Color(0xFF1B5E20),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Choose address at next step',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
