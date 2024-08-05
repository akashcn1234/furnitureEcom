import 'cartmodel.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final int totalPrice;
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.orderDate,
  });
}
