import "package:flutter/material.dart";

const List<Map<String, dynamic>> tabCategories = [
  {
    'name': 'All',
    'color': Color(0xFF2E7D32), // Green
    'icon': Icons.grid_view,
    'products': [
      {
        'name': 'Groceries',
        'icon': Icons.local_grocery_store,
        'color': Color(0xFFFF5722),
        'images': [
          'assets/images/groceries/flour.jpg',
          'assets/images/groceries/rice.jpg',
          'assets/images/groceries/pulses.jpg',
        ],
      },
      {
        'name': 'Beauty',
        'icon': Icons.face,
        'color': Color(0xFFE91E63),
        'images': [
          'assets/images/beauty/skincare.jpg',
          'assets/images/beauty/haircare.jpg',
          'assets/images/beauty/makeup.jpg',
        ],
      },
      {
        'name': 'Medicines',
        'icon': Icons.local_pharmacy,
        'color': Color(0xFF2196F3),
        'images': [
          'assets/images/medicines/tablets.jpg',
          'assets/images/medicines/syrups.jpg',
          'assets/images/medicines/healthcare.jpg',
        ],
      },
      {
        'name': 'Clothes',
        'icon': Icons.checkroom,
        'color': Color(0xFF9C27B0),
        'images': [
          'assets/images/clothes/casual.jpg',
          'assets/images/clothes/formal.jpg',
          'assets/images/clothes/accessories.jpg',
        ],
      },
      {
        'name': 'Organic Food',
        'icon': Icons.eco,
        'color': Color(0xFF4CAF50),
        'images': [
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/fruits.jpg',
          'assets/images/organic/grains.jpg',
        ],
      },
      {
        'name': 'Home Decor',
        'icon': Icons.home,
        'color': Color(0xFF9E9E9E),
        'images': [
          'assets/images/home_decor/furniture.jpg',
          'assets/images/home_decor/lighting.jpg',
          'assets/images/home_decor/accessories.jpg',
        ],
      },
      {
        'name': 'Hygiene',
        'icon': Icons.clean_hands,
        'color': Color(0xFF00BCD4),
        'images': [
          'assets/images/hygiene/soaps.jpg',
          'assets/images/hygiene/sanitizers.jpg',
          'assets/images/hygiene/cleaning.jpg',
        ],
      },
      {
        'name': 'Electronics',
        'icon': Icons.electrical_services,
        'color': Color(0xFF607D8B),
        'images': [
          'assets/images/electronics/gadgets.jpg',
          'assets/images/electronics/accessories.jpg',
          'assets/images/electronics/home_appliances.jpg',
        ],
      },
      {
        'name': 'Dairy Products',
        'icon': Icons.water_drop,
        'color': Color(0xFF64B5F6),
        'images': [
          'assets/images/dairy/milk.jpg',
          'assets/images/dairy/cheese.jpg',
          'assets/images/dairy/yogurt.jpg',
        ],
      },
    ],
  },
  {
    'name': 'Immediate Needs',
    'color': Color(0xFF1976D2), // Blue
    'icon': Icons.flash_on,
    'products': [
      {
        'name': 'Fresh Vegetables',
        'icon': Icons.eco,
        'color': Color(0xFF4CAF50),
        'images': [
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/vegetables.jpg',
        ],
      },
      {
        'name': 'Fresh Fruits',
        'icon': Icons.apple,
        'color': Color(0xFFFF9800),
        'images': [
          'assets/images/fruits/fresh_fruits.jpg',
          'assets/images/fruits/seasonal.jpg',
          'assets/images/fruits/exotic.jpg',
        ],
      },
      {
        'name': 'Bread',
        'icon': Icons.bakery_dining,
        'color': Color(0xFFFFB74D),
        'images': [
          'assets/images/bread/white_bread.jpg',
          'assets/images/bread/brown_bread.jpg',
          'assets/images/bread/buns.jpg',
        ],
      },
      {
        'name': 'Milk',
        'icon': Icons.local_drink,
        'color': Color(0xFF64B5F6),
        'images': [
          'assets/images/milk/fresh_milk.jpg',
          'assets/images/milk/curd.jpg',
          'assets/images/milk/butter.jpg',
        ],
      },
      {
        'name': 'Dry Fruits',
        'icon': Icons.cake,
        'color': Color(0xFF795548),
        'images': [
          'assets/images/dry_fruits/nuts.jpg',
          'assets/images/dry_fruits/seeds.jpg',
          'assets/images/dry_fruits/mix.jpg',
        ],
      },
      {
        'name': 'Snacks',
        'icon': Icons.restaurant,
        'color': Color(0xFFFF9800),
        'images': [
          'assets/images/food/snacks.jpg',
          'assets/images/food/snacks.jpg',
          'assets/images/food/snacks.jpg',
        ],
      },
      {
        'name': 'Hygiene Essentials',
        'icon': Icons.clean_hands,
        'color': Color(0xFF00BCD4),
        'images': [
          'assets/images/hygiene/soaps.jpg',
          'assets/images/hygiene/sanitizers.jpg',
          'assets/images/hygiene/cleaning.jpg',
        ],
      },
      {
        'name': 'Dairy & Eggs',
        'icon': Icons.water_drop,
        'color': Color(0xFF64B5F6),
        'images': [
          'assets/images/dairy/milk.jpg',
          'assets/images/dairy/eggs.jpg',
          'assets/images/dairy/butter.jpg',
        ],
      },
    ],
  },
  {
    'name': 'Trending',
    'color': Color(0xFFD32F2F), // Red
    'icon': Icons.trending_up,
    'products': [
      {
        'name': 'Organic Food',
        'icon': Icons.eco,
        'color': Color(0xFF4CAF50),
        'images': [
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/fruits.jpg',
          'assets/images/organic/grains.jpg',
        ],
      },
      {
        'name': 'Smart Devices',
        'icon': Icons.devices,
        'color': Color(0xFF607D8B),
        'images': [
          'assets/images/smart_devices/wearables.jpg',
          'assets/images/smart_devices/home_automation.jpg',
          'assets/images/smart_devices/accessories.jpg',
        ],
      },
      {
        'name': 'Fitness Gear',
        'icon': Icons.fitness_center,
        'color': Color(0xFF795548),
        'images': [
          'assets/images/fitness/equipment.jpg',
          'assets/images/fitness/accessories.jpg',
          'assets/images/fitness/supplements.jpg',
        ],
      },
      {
        'name': 'Home Decor',
        'icon': Icons.home,
        'color': Color(0xFF9E9E9E),
        'images': [
          'assets/images/home_decor/furniture.jpg',
          'assets/images/home_decor/lighting.jpg',
          'assets/images/home_decor/accessories.jpg',
        ],
      },
      {
        'name': 'Ayurvedic',
        'icon': Icons.spa,
        'color': Color(0xFF8BC34A),
        'images': [
          'assets/images/medicines/tablets.jpg',
          'assets/images/medicines/syrups.jpg',
          'assets/images/medicines/healthcare.jpg',
        ],
      },
      {
        'name': 'Personal Care',
        'icon': Icons.face,
        'color': Color(0xFFE91E63),
        'images': [
          'assets/images/beauty/skincare.jpg',
          'assets/images/beauty/haircare.jpg',
          'assets/images/beauty/makeup.jpg',
        ],
      },
      {
        'name': 'Electronics',
        'icon': Icons.electrical_services,
        'color': Color(0xFF607D8B),
        'images': [
          'assets/images/electronics/gadgets.jpg',
          'assets/images/electronics/accessories.jpg',
          'assets/images/electronics/home_appliances.jpg',
        ],
      },
      {
        'name': 'Dairy & Alternatives',
        'icon': Icons.water_drop,
        'color': Color(0xFF64B5F6),
        'images': [
          'assets/images/dairy/milk.jpg',
          'assets/images/dairy/plant_milk.jpg',
          'assets/images/dairy/yogurt.jpg',
        ],
      },
    ],
  },
  {
    'name': 'Saatvik Aahar',
    'color': Color(0xFFFF9800), // Saffron
    'icon': Icons.self_improvement,
    'products': [
      {
        'name': 'Fresh Fruits',
        'icon': Icons.apple,
        'color': Color(0xFFE91E63),
        'images': [
          'assets/images/fruits/fresh_fruits.jpg',
          'assets/images/fruits/seasonal.jpg',
          'assets/images/fruits/exotic.jpg',
        ],
      },
      {
        'name': 'Dry Fruits',
        'icon': Icons.cake,
        'color': Color(0xFF795548),
        'images': [
          'assets/images/dry_fruits/nuts.jpg',
          'assets/images/dry_fruits/seeds.jpg',
          'assets/images/dry_fruits/mix.jpg',
        ],
      },
      {
        'name': 'Milk Products',
        'icon': Icons.water_drop,
        'color': Color(0xFF64B5F6),
        'images': [
          'assets/images/milk_products/paneer.jpg',
          'assets/images/milk_products/curd.jpg',
          'assets/images/milk_products/ghee.jpg',
        ],
      },
      {
        'name': 'Grains',
        'icon': Icons.grass,
        'color': Color(0xFF8D6E63),
        'images': [
          'assets/images/grains/rice.jpg',
          'assets/images/grains/wheat.jpg',
          'assets/images/grains/millets.jpg',
        ],
      },
      {
        'name': 'Fresh Vegetables',
        'icon': Icons.eco,
        'color': Color(0xFF4CAF50),
        'images': [
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/vegetables.jpg',
          'assets/images/organic/vegetables.jpg',
        ],
      },
      {
        'name': 'Organic Snacks',
        'icon': Icons.restaurant,
        'color': Color(0xFFFF9800),
        'images': [
          'assets/images/food/snacks.jpg',
          'assets/images/food/snacks.jpg',
          'assets/images/food/snacks.jpg',
        ],
      },
    ],
  },
];

final List<Map<String, dynamic>> searchIcons = [
  {'icon': Icons.apple, 'text': 'fruits'},
  {'icon': Icons.checkroom, 'text': 'clothing'},
  {'icon': Icons.devices, 'text': 'electronics'},
  {'icon': Icons.local_grocery_store, 'text': 'groceries'},
  {'icon': Icons.local_drink, 'text': 'beverages'},
  {'icon': Icons.local_pharmacy, 'text': 'medicines'},
];
