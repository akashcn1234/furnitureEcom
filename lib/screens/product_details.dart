import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cartmodel.dart';
import '../utils/colors.dart';
import '../view model/cartviewmodel.dart';
import 'cartscreen.dart';


class Details extends StatefulWidget {
  const Details({
    Key? key,
    this.dImage,
    this.dName,
    this.dRating,
    this.dCalorie,
    this.dTime,
    this.DText,
    this.dPrice,
    this.dId,
  }) : super(key: key);

  final String? dImage;
  final String? dName;
  final int? dPrice;
  final double? dRating;
  final double? dCalorie;
  final int? dTime;
  final String? DText;
  final String? dId;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _counter = 1;
  int _totalPrice = 0;
  bool _isFavorite = false;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.dPrice ?? 0;
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: primaryColors,
        content: const Text('Added to cart'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _totalPrice = (widget.dPrice ?? 0) * _counter;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _totalPrice = (widget.dPrice ?? 0) * _counter;
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _toggleReadMore() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _addToCart() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(),));
    final cartItem = CartItem(
      id: widget.dId ?? '',
      name: widget.dName ?? '',
      image: widget.dImage ?? '',
      price: widget.dPrice ?? 0,
      quantity: _counter,
    );

    context.read<CartViewModel>().addItem(cartItem);
    _showSnackBar();

  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Confirmed'),
          content: Text('Thank you for your purchase!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Close the Details screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String text =
        "Buy furniture online @ Pepperfry, India's largest home shopping destination offering a wide range of home and office furniture online. Choosing the right furniture for your home online will add elegance and functionality to your interior decor, while also being cost effective and long lasting.";

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(),
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 134,
              child: Text(
                "Details",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Airbnb",
                  color: Colors.white70,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              top: 290,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: 120,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: _toggleFavorite,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 77,
              left: 20,
              right: 20,
              child: widget.dImage != null
                  ? Hero(
                tag: widget.dImage!,
                child: Image.network(
                  widget.dImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
              )
                  : Container(),
            ),
            Positioned(
              top: 350,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Best seller",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    widget.dName ?? "",
                    style: const TextStyle(
                      fontFamily: "Airbnb",
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 455,
              left: 20,
              child: Text(
                "₹$_totalPrice",
                style: TextStyle(
                  fontFamily: "Airbnb",
                  fontSize: 25,
                  color: primaryColors,
                ),
              ),
            ),
            Positioned(
              bottom: 180,
              left: 25,
              child: const Text(
                "FURNITUR @ ONLINE",
                style: TextStyle(
                  fontFamily: "Airbnb",
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 572,
              bottom: 80,
              left: 18,
              child: SingleChildScrollView(
                child: Container(
                  width: 310,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _expanded
                          ? Text(
                        text,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      )
                          : Text(
                        text,
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _toggleReadMore,
                        child: Text(
                          _expanded ? 'Read Less' : 'Read More',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _addToCart,
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
