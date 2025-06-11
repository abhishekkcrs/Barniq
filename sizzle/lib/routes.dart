import 'package:flutter/material.dart';
// import 'oldstuff/homepage.dart';
import 'pages/product_listing_page.dart';
import 'pages/cart_page.dart';
import 'pages/login_page.dart';
import 'pages/splash_page.dart';
import 'pages/profile_page.dart';
import 'pages/search_page.dart' as search_page;
import 'pages/homepage.dart';
// import 'hame_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String productListing = '/product-listing';
  static const String cart = '/cart';
  static const String search = '/search';
  static const String home2 = '/home2';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      // case home2:
      // return MaterialPageRoute(builder: (_) => const hame_page.HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case productListing:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) =>
              ProductListingPage(selectedCategory: args['category']),
        );
      case cart:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case search:
        return MaterialPageRoute(
            builder: (_) => const search_page.SearchPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
