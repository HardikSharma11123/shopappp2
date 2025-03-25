class Product {
  final int id;
  final String name;
  final String company;
  final String imageUrl;
  final double originalPrice;
  final double discountedPrice;

  Product({
    required this.id,
    required this.name,
    required this.company,
    required this.imageUrl,
    required this.originalPrice,
    required this.discountedPrice,
  });

  /// Getter to calculate discount percentage
  double get discountPercentage {
    return ((originalPrice - discountedPrice) / originalPrice) * 100;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    double discountPercent = json['discountPercentage'].toDouble();
    double discountedPrice = json['price'] * (1 - discountPercent / 100);

    return Product(
      id: json['id'],
      name: json['title'],
      company: json['brand'] ?? "Unknown",
      imageUrl: json['thumbnail'],
      originalPrice: json['price'].toDouble(),
      discountedPrice: discountedPrice,
    );
  }
}
