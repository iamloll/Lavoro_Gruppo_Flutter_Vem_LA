import 'package:flutter/material.dart';

class ShareButtons extends StatelessWidget {
  final String imagePath;
  final Function()? onPressed;

  const ShareButtons({
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SizedBox(
        width: 35,
        height: 35,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
