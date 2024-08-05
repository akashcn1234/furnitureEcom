import 'package:ecom/screens/view_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/vieworder.dart';
import '../utils/colors.dart';
import '../view model/cartviewmodel.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];
                return ListTile(
                  leading: Image.network(item.image),
                  title: Text(item.name),
                  subtitle: Text('₹${item.price} x ${item.quantity}'),
                  trailing: Text('₹${item.price * item.quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: ₹${cart.totalPrice}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColors,
                  ),
                  onPressed: () {
                    _confirmPurchase(context);
                  },
                  child: Center(
                    child: Text(
                      'Confirm Purchase',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmPurchase(BuildContext context) {
    final cart = context.read<CartViewModel>();

    final order = OrderModel(
      id: Uuid().v4(),
      items: List.from(cart.cartItems),
      totalPrice: cart.totalPrice,
      orderDate: DateTime.now(),
    );

    cart.addOrder(order);
    cart.clearCart();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Confirmed'),
          content: Text('Thank you for your purchase!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewProducts(),));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
