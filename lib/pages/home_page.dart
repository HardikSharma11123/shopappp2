import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_item.dart';
import 'cart_page.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(cartProvider.notifier).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(252, 228, 236, 1),
        centerTitle: true,
        title: Text("Catalouge"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, size: 32),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child:
                      cartItems.isEmpty
                          ? Text(
                            "00",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )
                          : Text(
                            '${cartItems.length}',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ref
          .watch(productProvider)
          .when(
            data:
                (productList) => SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.all(2),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.62,
                              ),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return ProductItem(product: productList[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text("Error loading products")),
          ),
    );
  }
}
