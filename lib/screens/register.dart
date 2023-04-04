import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Logo(title: 'Register',),
                _Form(),
                const Labels(
                  ask: 'Already have an account?',
                  btnText: 'Log in with your account',
                  routeName: 'login',
                ),
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
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCrtl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCrtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
        CustomInput(
            textController: nameCrtl,
            placeholder: 'Name',
            icon: Icons.perm_identity),
        CustomInput(
          textController: emailCtrl,
          placeholder: 'Email address',
          icon: Icons.email_outlined,
          inputType: TextInputType.emailAddress,
        ),
        CustomInput(
          textController: passCrtl,
          placeholder: 'Password',
          icon: Icons.lock,
          isPassword: true,
        ),
        Button(onPressed: _handleLogin, textBtn: 'Ingresar')
      ]),
    );
  }

  void _handleLogin() {
    print(emailCtrl.text);
    print(passCrtl.text);
  }
}
