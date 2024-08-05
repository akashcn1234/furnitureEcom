import 'package:ecom/screens/view_order.dart';
import 'package:ecom/screens/view_product.dart';
import 'package:ecom/screens/view_product_user.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';
import '../utils/colors.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  void clearSearchQuery() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_searchQuery.isNotEmpty) {
          clearSearchQuery();
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: Drawer(),
        body: Container(
          color: Colors.white60,
          child: Column(
            children: [
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Icon(Icons.menu),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "  Store location",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryColors,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Calicut,KL",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add navigation to UserProfileScreen here
                      },
                      child: CircleAvatar(
                        radius: 21,
                        backgroundImage:
                        const AssetImage("assets/images/Group 27@2x.png"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> items = [
                      {
                        'title': 'Add Product',
                        'icon': Icons.add,
                        'route': AddProduct(),
                      },
                      {
                        'title': 'Update Product',
                        'icon': Icons.edit,
                        'route': ViewProductsUser(),
                      },
                      {
                        'title': 'View Orders',
                        'icon': Icons.list,
                        'route': ViewOrdersScreen(), // Replace with actual page
                      },
                      {
                        'title': 'View Reviews',
                        'icon': Icons.rate_review,
                        'route': Placeholder(), // Replace with actual page
                      },
                      {
                        'title': 'View Complaint',
                        'icon': Icons.report_problem,
                        'route': Placeholder(), // Replace with actual page
                      }
                    ];
                    return Card(
                      color: primaryColors,
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          _navigateTo(items[index]['route']);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(items[index]['icon'], size: 40, color: Colors.white),
                            const SizedBox(height: 10),
                            Text(
                              items[index]['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
