import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:certification_ecommerce_riverpod/data/models/models.dart';

class MockProductDataSource {

  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final String jsonString =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Product(
              id: json['id'] as String,
              name: json['name'] as String,
              price: (json['price'] as num).toDouble(),
              description: json['description'] as String,
              imageUrl: json['imageUrl'] as String,
              category: json['category'] as String,
              rating: (json['rating'] as num).toDouble(),
            ))
        .toList();
  }

  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final products = await getProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
