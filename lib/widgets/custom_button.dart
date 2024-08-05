import 'package:flutter/material.dart';

import '../utils/colors.dart';



class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColors,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
