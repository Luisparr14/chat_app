import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key, required this.ask, required this.btnText, required this.routeName});

  final String ask;
  final String btnText;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        ask,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black26),
      ),
      GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, routeName),
        child: Text(
          btnText,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
    ]);
  }
}
