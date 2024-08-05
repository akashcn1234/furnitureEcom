import 'package:flutter/material.dart';

import 'add_product.dart';
import '../utils/colors.dart';
import '../widgets/custom_drawer.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    AddProduct(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        toolbarHeight: 0,
      ),
      drawer: CustomDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          shape: CircleBorder(),
          elevation: 5,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
          backgroundColor: primaryColors,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () => _onItemTapped(0),
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? primaryColors : Colors.grey,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () => _onItemTapped(1),
              icon: Icon(
                Icons.account_circle_rounded,
                color: _selectedIndex == 1 ? primaryColors : Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
