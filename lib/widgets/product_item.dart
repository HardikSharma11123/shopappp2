import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductItem extends ConsumerWidget {
  final Product product;

  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(left: 2, right: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  product.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1, //  Prevents text overflow
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  product.company,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "\$${product.originalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "\$${product.discountedPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${product.discountPercentage.toStringAsFixed(2)}% OFF",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
