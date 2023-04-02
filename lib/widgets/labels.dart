import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Text(
        '¿No tienes cuenta?',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black26),
      ),
      Text(
        'Crea una ahora',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
    ]);
  }
}