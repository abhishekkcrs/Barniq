class Product {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final int categoryId;
  final String category;
  final int ratingsCount;
  final String brand;
  final int price;
  final double ratings;
  final int quantity;
  final DateTime dateAdded;
  final double discountPercentage;
  final List<String> reviews;
  final String videoUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.categoryId,
    required this.category,
    required this.ratingsCount,
    required this.brand,
    required this.price,
    required this.ratings,
    required this.quantity,
    required this.dateAdded,
    required this.discountPercentage,
    required this.reviews,
    required this.videoUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrls: List<String>.from(json['imageUrls']),
      categoryId: json['categoryId'],
      category: json['category'],
      ratingsCount: json['ratings_count'],
      brand: json['brand'],
      price: json['price'],
      ratings:
          json['ratings']?.toDouble() ?? 0.0, // Ensures null safety for ratings
      quantity: json['quantity'],
      dateAdded: DateTime.parse(json['date_added']),
      discountPercentage: json['discount_percentage']?.toDouble() ??
          0.0, // Ensures null safety for discount percentage
      reviews: List<String>.from(json['reviews']),
      videoUrl: json['video_url'],
    );
  }
}
