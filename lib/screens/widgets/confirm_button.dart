import 'package:flutter/material.dart';

class BackButtonCircle extends StatelessWidget {
  final Alignment alignment;
  final Color backgroundColor;
  final Color iconColor;

  const BackButtonCircle({
    super.key,
    this.alignment = Alignment.topLeft,
    this.backgroundColor = Colors.black,
    this.iconColor = const Color(0xFFE1A948),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
