import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view model/cartviewmodel.dart';


class ViewOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = context.watch<CartViewModel>().orders;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders found'))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ExpansionTile(
            title: Text('Order ${order.id}'),
            subtitle: Text('Total: ₹${order.totalPrice}'),
            children: [
              for (var item in order.items)
                ListTile(
                  leading: Image.network(item.image),
                  title: Text(item.name),
                  subtitle: Text('₹${item.price} x ${item.quantity}'),
                  trailing: Text('₹${item.price * item.quantity}'),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Order Date: ${order.orderDate}'),
              ),
            ],
          );
        },
      ),
    );
  }
}
