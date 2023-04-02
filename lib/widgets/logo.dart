import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: 160,
      child: Column(
        children: [
          const Image(image: AssetImage('assets/tag-logo.png')),
          const SizedBox(
            height: 10,
          ),
          Text(title, style: const TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
