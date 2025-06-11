import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../commons/widgets/productCard.dart';
import '../providers/product_provider.dart';
import '../commons/widgets/custom_search_bar.dart';
import '../routes.dart';

class ProductListingPage extends ConsumerStatefulWidget {
  final String selectedCategory;

  const ProductListingPage({
    super.key,
    required this.selectedCategory,
  });

  @override
  ConsumerState<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends ConsumerState<ProductListingPage> {
  final ScrollController _scrollController = ScrollController();
  List<String> _searchSuggestions = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initialize with the selected category after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(paginatedProductsProvider.notifier)
          .setProductName(widget.selectedCategory);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(paginatedProductsProvider.notifier).loadProducts();
    }
  }

  Future<void> _loadSearchSuggestions() async {
    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _searchSuggestions = [
        'Fresh Fruits',
        'Organic Vegetables',
        'Dairy Products',
        'Bakery Items',
        'Meat & Seafood',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(paginatedProductsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing:
              0, // <-- This removes extra spacing between leading and title
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0), // optional: add right padding if needed
                  child: CustomSearchBar(
                    onSearchTap: () {
                      Navigator.pushNamed(context, AppRoutes.search);
                    },
                    onSearchChanged: (value) {
                      _loadSearchSuggestions();
                    },
                    searchSuggestions: _searchSuggestions,
                    isLoading: false,
                    initialSearchText: widget.selectedCategory,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: productsState.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index == products.length) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  // TODO: Navigate to product details
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
