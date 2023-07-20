import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget {
  const WhiteCard({
    super.key,
    required this.child,
    this.title,
    this.color = Colors.white,
    this.width,
    this.heigth,
  });
  final Widget child;
  final double? width;
  final double? heigth;
  final String? title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      width: width,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: buildBox(color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBox(Color color) => BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}
