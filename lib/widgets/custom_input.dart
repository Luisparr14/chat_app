import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
      super.key,
      required this.textController,
      required this.icon,
      required this.placeholder,
      this.isPassword = false,
      this.inputType = TextInputType.text
    });

  final TextEditingController textController;
  final IconData icon;
  final String placeholder;
  final bool isPassword;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.only(left: 5, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 3)),
          ]),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: inputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          hintText: placeholder,
        ),
        obscureText: isPassword,
      ),
    );
  }
}
