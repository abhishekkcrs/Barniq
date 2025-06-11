import 'package:flutter/material.dart';
import '../../pages/product_detail_page.dart';
import 'custom_card.dart';
import '../../widgets/product_card.dart';
import '../../entities/product.dart';
import '../../entities/grocery_product.dart';

class RecommendedProductsCard extends StatelessWidget {
  final List<GroceryProduct> recommendedItems;

  const RecommendedProductsCard({super.key, required this.recommendedItems});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You might also like',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              // First row
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (recommendedItems.length / 2).ceil(),
                  separatorBuilder: (context, i) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final item = recommendedItems[i];
                    return ProductCard(
                      item: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              product: item,
                              similarProducts: recommendedItems,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Second row
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (recommendedItems.length / 2).floor(),
                  separatorBuilder: (context, i) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final item = recommendedItems[
                        i + (recommendedItems.length / 2).ceil()];
                    return ProductCard(
                      item: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              product: item,
                              similarProducts: recommendedItems,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/1046/1046857.png',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(width: 8),
                const Text(
                  'See all products',
                  style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
