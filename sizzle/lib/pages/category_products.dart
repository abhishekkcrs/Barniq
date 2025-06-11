import 'package:flutter/material.dart';
import '../entities/grocery_product.dart';
import '../widgets/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;
  final IconData icon;
  final String? imageUrl;

  const CategoryProductsPage({
    Key? key,
    required this.categoryName,
    required this.icon,
    this.imageUrl,
  }) : super(key: key);

  List<GroceryProduct> getCategoryProducts() {
    // Generate mock products based on category
    return List.generate(
      12,
      (i) => GroceryProduct(
        title: '$categoryName Product ${i + 1}',
        icon: icon,
        color: Colors.primaries[i % Colors.primaries.length],
        price: (i + 1) * 99.0,
        discount: (i + 1) * 5.0,
        image: 'assets/images/core/icon.png',
        weight: '1 kg',
        rating: 4.5,
        reviews: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Color(0xFFFFF8E1),
        iconTheme: IconThemeData(color: Colors.brown),
        titleTextStyle: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFF8E1),
      body: Column(
        children: [
          // Products grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: getCategoryProducts().length,
              itemBuilder: (context, index) {
                return ProductCard(item: getCategoryProducts()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
