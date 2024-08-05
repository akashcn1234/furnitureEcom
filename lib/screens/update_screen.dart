import 'dart:io';
import 'dart:ui';

import 'package:ecom/models/product_model.dart';
import 'package:ecom/view%20model/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';


class UpdateProduct extends StatefulWidget {
  UpdateProduct(
      {Key? key,
      required this.itemname,
      required this.price,
      required this.name,
      required this.image,
      required this.SId})
      : super(key: key);
  final String SId;
  final String itemname;
  final int price;
  final String name;
  final String image;

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  XFile? image;
  final TextEditingController itemnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    itemnameController.text = widget.itemname;
    nameController.text = widget.name;
    priceController.text = widget.price.toString();
    image = XFile(widget.image);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(35.0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add photo",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Airbnb",
                              fontSize: 20)),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[200],
                                title: Text("Remove Photo"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        image = null;
                                      });
                                    },
                                    child: Text("Remove",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 65,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColors,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final pickedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColors,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    final pickedImage = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedImage != null) {
                                      setState(() {
                                        image = pickedImage;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    size: 30,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColors)),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColors,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 15,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
              top: 45,
              left: 120,
              child: Text(
                "Update Product",
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
              top: 90,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _showBottomSheet(context);
                            },
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: image == null
                                  ? null
                                  : FileImage(File(image!.path)),
                              child: image == null
                                  ? Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.black,
                                      size: 50,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: widget.itemname,
                          hintText: widget.itemname,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: widget.price.toString(),
                          hintText: widget.price.toString(),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: itemnameController,
                        decoration: InputDecoration(
                          labelText: widget.name,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      Consumer<ProductViewModel>(
                        builder: (context, productViewModel, _) {
                          return Column(
                            children: [
                              CustomButton(
                                onPressed: () {
                                  if (image != null) {
                                    ProductModel updatedProduct = ProductModel(
                                      id: widget.SId,
                                      name: nameController.text,
                                      price: int.parse(priceController.text),
                                      item: itemnameController.text,
                                    );

                                    productViewModel.updateProduct(
                                      product: updatedProduct,
                                      imageFile: File(image!.path),
                                      context: context,
                                    );
                                  }
                                },
                                name: 'Update Product',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (image != null) {
                                    ProductModel updatedProduct = ProductModel(
                                      id: widget.SId,
                                      name: nameController.text,
                                      price: int.parse(priceController.text),
                                      item: itemnameController.text,
                                    );

                                    productViewModel.deleteProduct(
                                      productId: widget.SId,
                                      context: context,
                                    );
                                  }
                                },
                                child: Text('Delete Product'),
                              ),
                            ],
                          );
                        },
                      )
                    ],
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
