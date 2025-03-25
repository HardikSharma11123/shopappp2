import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../utils/api_service.dart';

final productProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(() {
  return ProductNotifier();
});

class ProductNotifier extends AsyncNotifier<List<Product>> {
  List<Product> _products = [];
  int _skip = 0;
  final int _limit = 10;

  @override
  Future<List<Product>> build() async {
    return fetchMoreProducts();
  }

  Future<List<Product>> fetchMoreProducts() async {
    state = const AsyncLoading();
    try {
      final newProducts = await ApiService.fetchProducts(_skip, _limit);
      _skip += _limit;
      _products = [..._products, ...newProducts];
      state = AsyncData(_products);
      return _products;
    } catch (e) {
      state = state = AsyncError(e, StackTrace.current);
      return [];
    }
  }
}
