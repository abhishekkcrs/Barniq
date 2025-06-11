import 'package:flutter/material.dart';

class GroceryProduct {
  final String title;
  final IconData icon;
  final Color color;
  final double price;
  final double discount;
  final String image;
  final String weight;
  final String? tag;
  final double? mrp;
  final double rating;
  final int reviews;

  const GroceryProduct({
    required this.title,
    required this.icon,
    required this.color,
    required this.price,
    required this.discount,
    required this.image,
    required this.weight,
    this.tag,
    this.mrp,
    required this.rating,
    required this.reviews,
  });
}
