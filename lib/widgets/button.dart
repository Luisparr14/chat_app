import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.textBtn});

  final void Function()? onPressed;
  final String textBtn;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          textBtn,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
