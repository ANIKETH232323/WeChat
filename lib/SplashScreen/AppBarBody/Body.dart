import 'package:flutter/material.dart';

class BodyAppBar extends StatelessWidget {
  const BodyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              "Messages",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        )
      ],
    );
  }
}
