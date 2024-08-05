import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

import '../view model/cartviewmodel.dart';
import 'checkoutscreen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cart.cartItems.isEmpty
          ? Center(
        child: Text('Your cart is empty'),
      )
          : Column(
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
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => cart.removeItem(item.id),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ₹${cart.totalPrice}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColors,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
