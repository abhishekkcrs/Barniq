import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizzle/routes.dart';
import 'package:sizzle/providers/product_provider.dart';
import 'dart:async';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  List<String> _searchSuggestions = [];
  bool _isLoading = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
    _loadSearchSuggestions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadSearchSuggestions() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _searchSuggestions = [
        'Fresh Fruits',
        'Organic Vegetables',
        'Dairy Products',
        'Bakery Items',
      ];
      _isLoading = false;
    });
  }

  void _onSearchChanged(String value) {
    // Cancel any existing timer
    _debounceTimer?.cancel();

    // Set a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        // Update the product provider with the search query
        ref.read(paginatedProductsProvider.notifier).setProductName(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textPrimary =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final textSecondary =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey;
    final searchBarBackground =
        Theme.of(context).inputDecorationTheme.fillColor ?? Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: searchBarBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            autofocus: true,
            style: TextStyle(
              color: textPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(
                color: textSecondary,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onChanged: (value) {
              _onSearchChanged(value);
              _loadSearchSuggestions();
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                ref
                    .read(paginatedProductsProvider.notifier)
                    .setProductName(value);
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.productListing,
                  arguments: {'category': value},
                );
              }
            },
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _searchSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.search,
                    color: textSecondary,
                  ),
                  title: Text(
                    _searchSuggestions[index],
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    _searchController.text = _searchSuggestions[index];
                    // Update the product provider with the selected suggestion
                    ref
                        .read(paginatedProductsProvider.notifier)
                        .setProductName(_searchSuggestions[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
    );
  }
}
