import 'package:flutter/material.dart';

import '../models/cartmodel.dart';
import '../models/vieworder.dart';



class CartViewModel extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<OrderModel> _orders = [];

  List<CartItem> get cartItems => _cartItems;
  List<OrderModel> get orders => _orders;

  int get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = [];
    notifyListeners();
  }

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }
}
