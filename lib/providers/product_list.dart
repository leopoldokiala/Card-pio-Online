import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }
}
