import 'package:flutter/material.dart';

class OrderAgainPage extends StatefulWidget {
  const OrderAgainPage({super.key});

  @override
  State<OrderAgainPage> createState() => _OrderAgainPageState();
}

class _OrderAgainPageState extends State<OrderAgainPage> {
  // Mock data for recently bought items
  final List<Map<String, dynamic>> recentOrders = [
    {
      'name': 'Thums Up Soft Drink',
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500',
      'quantity': '750 ml',
      'price': 40.0,
      'lastOrdered': '2 days ago',
      'rating': 4.5,
      'reviews': 1234,
    },
    {
      'name': 'Lay\'s India\'s Magic Masala',
      'image':
          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500',
      'quantity': '48 g',
      'price': 20.0,
      'lastOrdered': '1 week ago',
      'rating': 4.3,
      'reviews': 5678,
    },
    {
      'name': 'Maggi Masala Noodles',
      'image':
          'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?w=500',
      'quantity': '280 g',
      'price': 60.0,
      'lastOrdered': '3 days ago',
      'rating': 4.6,
      'reviews': 3456,
    },
    {
      'name': 'Cadbury Dairy Milk',
      'image':
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500',
      'quantity': '150 g',
      'price': 55.0,
      'lastOrdered': '5 days ago',
      'rating': 4.4,
      'reviews': 2345,
    },
    {
      'name': 'Kurkure Masala Munch',
      'image':
          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=500',
      'quantity': '75 g',
      'price': 20.0,
      'lastOrdered': '4 days ago',
      'rating': 4.2,
      'reviews': 1789,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Order Again',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header with search and filter
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search in your orders',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.grey),
                ),
              ],
            ),
          ),
          // Recently bought items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recentOrders.length,
              itemBuilder: (context, index) {
                final item = recentOrders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['quantity'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${item['rating']}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${item['reviews']})',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Last ordered ${item['lastOrdered']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Price and Add Button
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${item['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    // TODO: Add to cart functionality
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1B5E20),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Divider with "Add to Cart" button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F8FA),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add to cart',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // TODO: Add to cart functionality
                              },
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Color(0xFF1B5E20),
                                size: 20,
                              ),
                              label: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Color(0xFF1B5E20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
    );
  }
}
