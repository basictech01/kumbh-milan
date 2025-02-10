import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12), // Adjust the border radius as needed
        ),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
