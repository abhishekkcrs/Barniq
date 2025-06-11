class ProductMin {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int price;
  final int ratingsCount;
  final double discountPercentage;

  const ProductMin({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.ratingsCount,
    required this.discountPercentage,
  });

  factory ProductMin.fromJson(Map<String, dynamic> json) {
    return ProductMin(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      price: json['price'] as int,
      ratingsCount: json['ratingsCount'] as int,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
    );
  }
}
