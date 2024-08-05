import 'package:flutter/material.dart';

class ConfirmedOrder extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String totalPrice;

  ConfirmedOrder({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Thank you for your order!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text("Order ID"),
              subtitle: Text(orderId),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text("Order Date"),
              subtitle: Text(orderDate),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Total Price"),
              subtitle: Text("\$$totalPrice"),
            ),
            Divider(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
