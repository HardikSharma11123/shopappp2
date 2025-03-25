import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String apiUrl = "https://dummyjson.com/products";

  static Future<List<Product>> fetchProducts(int skip, int limit) async {
    final response =
        await http.get(Uri.parse("$apiUrl?limit=$limit&skip=$skip"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
