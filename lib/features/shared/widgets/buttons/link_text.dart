import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  const LinkText({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              decoration: isHovered ? TextDecoration.underline : null,
              decorationColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
