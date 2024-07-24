import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/product/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl; // Add imageUrl to CartItem

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl, // Add imageUrl to constructor
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem({required Product product}) {
    if (_items.containsKey(product.id.toString())) {
      _items.update(
        product.id.toString(),
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          productId: existingCartItem.productId,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl, // Update imageUrl
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
        () => CartItem(
          id: DateTime.now().toString(),
          productId: product.id.toString(),
          title: product.title!,
          quantity: 1,
          price: product.price!,
          imageUrl: product.image!, // Add imageUrl
        ),
      );
    }
    notifyListeners();
  }

  void reduceQuantity({required Product product}) {
    if (_items.containsKey(product.id.toString())) {
      if (_items[product.id.toString()]!.quantity > 1) {
        _items.update(
          product.id.toString(),
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            productId: existingCartItem.productId,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price,
            imageUrl: existingCartItem.imageUrl, // Update imageUrl
          ),
        );
      } else {
        _items.remove(product.id.toString());
      }
    }
    notifyListeners();
  }
   

  void removeItemForDismissable(String productId) {
    // remove with productId
    _items.removeWhere((key, value) => value.productId == productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  int getQuantity(Product product) {
    if (_items.containsKey(product.id.toString())) {
      return _items[product.id.toString()]!.quantity;
    } else {
      return 0;
    }
  }
}
