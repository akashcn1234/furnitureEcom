import 'dart:convert';
import 'dart:io';

import 'package:ecom/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';


class ProductServices {
  Future<void> addProduct({
    required ProductModel product,
    required File imageFile,
  }) async {
    final Uri url = Uri.parse('$baseUrl/api/product/addProduct');
    final request = http.MultipartRequest('POST', url)
      ..fields['name'] = product.name ?? ''
      ..fields['price'] = product.price.toString()
      ..fields['item'] = product.item ?? ''
      ..files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      );

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        print('Product added successfully');
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final Uri url = Uri.parse('$baseUrl/api/product/viewProduct');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['data'] is List) {
          var productList = (data['data'] as List)
              .map(
                  (item) => ProductModel.fromJson(item as Map<String, dynamic>))
              .toList();

          return productList;
        } else {
          throw Exception('The key "data" does not contain a list');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> updateProduct({
    required ProductModel product,
    File? imageFile,
  }) async {
    final Uri url =
        Uri.parse('$baseUrl/api/product/updateProduct/${product.id}');
    final request = http.MultipartRequest('PUT', url)
      ..fields['name'] = product.name ?? ''
      ..fields['price'] = product.price.toString()
      ..fields['item'] = product.item ?? '';

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      );
    }

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        print('Failed to update product: ${response.statusCode}');
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final Uri url = Uri.parse('$baseUrl/api/product/deleteProduct/$productId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
