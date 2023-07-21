import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    this.onPressed,
    this.textColor,
    this.color = Colors.blue,
    this.filled = false,
    required this.text,
  });
  final Function()? onPressed;
  final Color color;
  final Color? textColor;
  final bool filled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          side: MaterialStatePropertyAll(
            BorderSide(color: color),
          ),
          backgroundColor: MaterialStatePropertyAll(filled ? color.withOpacity(0.3) : Colors.transparent)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
      ),
    );
  }
}
