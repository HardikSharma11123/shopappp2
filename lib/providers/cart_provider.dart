import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';

class CartNotifier extends StateNotifier<Map<Product, int>> {
  CartNotifier() : super({}) {
    //  Delay initial data fetching
    Future.microtask(() => fetchData());
  }

  void fetchData() {
    // Fetch data logic here (if needed)
  }

  void addToCart(Product product) {
    state = {...state, product: (state[product] ?? 0) + 1};
  }

  void removeFromCart(Product product) {
    if (!state.containsKey(product)) return;

    final currentQuantity = state[product]!;
    if (currentQuantity > 1) {
      state = {...state, product: currentQuantity - 1};
    } else {
      state = Map.from(state)..remove(product);
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<Product, int>>((
  ref,
) {
  return CartNotifier();
});
