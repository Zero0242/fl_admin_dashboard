import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onPressed,
    this.isFilled = false,
    this.color = Colors.indigo,
    required this.icon,
    required this.text,
  });
  final Function()? onPressed;
  final bool isFilled;
  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        backgroundColor: WidgetStatePropertyAll(color),
        shadowColor: WidgetStatePropertyAll(color.withOpacity(0.5)),
        overlayColor: WidgetStatePropertyAll(color.withOpacity(0.3)),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
