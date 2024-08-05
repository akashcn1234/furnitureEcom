import 'dart:io';

import 'package:ecom/models/product_model.dart';
import 'package:ecom/service/product_services.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';


class ProductViewModel extends ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];

  final _productService = ProductServices();

  Future<void> addProduct(
      {required ProductModel product,
      required File imageFile,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.addProduct(product: product, imageFile: imageFile);
      CircularProgressIndicator();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Added Successfully"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add product: $e"),
      ));
    }
  }

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _productService.getProducts();
      print(products);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print('An error occurred: $e');
    }
  }

  Future<void> updateProduct(
      {required ProductModel product,
      File? imageFile,
      required BuildContext context}) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.updateProduct(
          product: product, imageFile: imageFile);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Updated Successfully"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update product: $e"),
      ));
    }
  }

  Future<void> deleteProduct({
    required String productId,
    required BuildContext context,
  }) async {
    try {
      loading = true;
      notifyListeners();

      await _productService.deleteProduct(productId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product Deleted Successfully"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete product: $e"),
      ));
    }
  }
}
