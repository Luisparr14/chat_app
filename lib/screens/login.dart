import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Logo(),
              _Form(),
              _Labels(),
              const Text(
                'Terminos y condicones de uso',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black26),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
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

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TextField(),
      const TextField(),
      ElevatedButton(onPressed: () {}, child: const Text('Ingresar'))
    ]);
  }
}

class _Labels extends StatelessWidget {
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
