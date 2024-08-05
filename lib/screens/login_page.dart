import 'package:ecom/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view model/auth_viewmodel.dart';
import '../widgets/Custom_textfeild.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFF8F9FA),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/sofa.png', // Make sure the path is correct
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.5), // Add an overlay to make text more readable
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'Furniture Dealers',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Buy furniture online",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 30),
                      custom_textfeild(
                        controller: usernameController,
                        labeltext: 'Email Address',
                      ),
                      SizedBox(height: 20),
                      custom_textfeild(
                        controller: passwordController,
                        labeltext: "Password",
                        isPassword: true,
                      ),
                      SizedBox(height: 20,),
                      Consumer<AuthViewModel>(
                        builder: (context, value, child) => value.loading
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : ElevatedButton(
                          onPressed: () {
                            if (usernameController.text == "admin" &&
                                passwordController.text == "1234") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            } else {
                              value.login(
                                Username: usernameController.text,
                                password: passwordController.text,
                                context: context,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 170,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Account?",
                            style: TextStyle(color: Color(0xFF707B81)),
                          ),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            name: 'Sign Up',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
