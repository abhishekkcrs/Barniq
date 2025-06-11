import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../entities/productmin.dart';

final productsProvider =
    FutureProvider.family<List<ProductMin>, String>((ref, productName) async {
  final response = await http.get(
    Uri.parse('http://192.168.250.169:9091/apis/search/product/$productName'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => ProductMin.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
});

// Provider for paginated products
final paginatedProductsProvider = StateNotifierProvider<
    PaginatedProductsNotifier, AsyncValue<List<ProductMin>>>((ref) {
  return PaginatedProductsNotifier();
});

class PaginatedProductsNotifier
    extends StateNotifier<AsyncValue<List<ProductMin>>> {
  PaginatedProductsNotifier() : super(const AsyncValue.data([]));

  static const int pageSize = 20;
  int currentPage = 0;
  bool hasMore = true;
  String currentProductName = '';

  Future<void> loadProducts() async {
    if (!hasMore || currentProductName.isEmpty) return;

    try {
      state = const AsyncValue.loading();
      final response = await http.get(
        Uri.parse(
            'http://192.168.250.169:9091/apis/search/product/$currentProductName?page=$currentPage&size=$pageSize'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final newProducts =
            jsonList.map((json) => ProductMin.fromJson(json)).toList();

        if (newProducts.isEmpty) {
          hasMore = false;
          if (currentPage == 0) {
            state = const AsyncValue.data([]);
          }
        } else {
          currentPage++;
          state = AsyncValue.data([...?state.value, ...newProducts]);
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void reset() {
    currentPage = 0;
    hasMore = true;
    state = const AsyncValue.data([]);
  }

  void setProductName(String productName) {
    if (currentProductName != productName) {
      currentProductName = productName;
      reset();
      loadProducts();
    }
  }
}
