import 'package:chat_app/helpers/show_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                const Logo(title: 'Messenger'),
                _Form(),
                const Labels(
                  ask: 'Don\'t have an account?',
                  btnText: 'Create an account now!',
                  routeName: 'register',
                ),
                const Text(
                  'Terms and conditions of use',
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
  final emailCtrl = TextEditingController();
  final passCrtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(children: [
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
        Button(
            onPressed: authService.getAuthenticating
                ? null
                : () => _handleLogin(context, authService),
            textBtn: 'Log in')
      ]),
    );
  }

  void _handleLogin(BuildContext context, AuthService authService) async {
    final socketService = Provider.of<SocketService>(context, listen: false);
    FocusScope.of(context).unfocus();
    final loginOk =
        await authService.login(emailCtrl.text.trim(), passCrtl.text.trim());

    if (loginOk) {
      Navigator.pushReplacementNamed(context, 'loading');
      socketService.connect();
    } else {
      showAlert(context, 'Failed to login', 'Please check your credentials');
    }
  }
}
