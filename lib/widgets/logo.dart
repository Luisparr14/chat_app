import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      width: 160,
      child: const Column(
        children: [
          Image(image: AssetImage('assets/tag-logo.png')),
          SizedBox(
            height: 10,
          ),
          Text('Messenger', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}