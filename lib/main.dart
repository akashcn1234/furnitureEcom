import 'package:ecom/screens/home_screen.dart';
import 'package:ecom/screens/login_page.dart';
import 'package:ecom/view%20model/auth_viewmodel.dart';
import 'package:ecom/view%20model/cartviewmodel.dart';
import 'package:ecom/view%20model/product_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
      ],
      child: MaterialApp(
        home: Login(),
        debugShowCheckedModeBanner: false,
      )));
}
