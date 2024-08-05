import 'package:ecom/models/product_model.dart';
import 'package:ecom/screens/login_page.dart';
import 'package:ecom/screens/product_details.dart';
import 'package:ecom/view%20model/product_viewmodel.dart';
import 'package:ecom/screens/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/custom_item.dart';

class ViewProducts extends StatefulWidget {
  ViewProducts({Key? key}) : super(key: key);

  @override
  State<ViewProducts> createState() => _FoodState();
}

class _FoodState extends State<ViewProducts> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Furnitures"),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
          return false;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: primaryColors)),
                  hintText: "Looking for Furnitures",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Consumer<ProductViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<ProductModel> filteredFoodItems = viewModel.products
                      .where((item) =>
                          item.name != null &&
                          item.name!
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                      .toList()
                      .reversed
                      .toList();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filteredFoodItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredFoodItems[index];
                      return custom_items(
                        image: item.image ?? '',
                        name: item.name ?? '',
                        price: (item.price ?? 0).toString(),
                        index: index,
                        onTapFull: () {},
                        onTapadd: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                dId: item.id ?? "",
                                // dName: item.name ?? "",
                                dPrice: item.price!,
                                dName: item.item ?? "",
                                    dImage: item.image ?? "",
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
