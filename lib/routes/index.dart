import 'package:chat_app/main.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/loading.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';

final appRoutes = {
  'home': (_) => const MyApp(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'chat': (_) => const ChatScreen(),
  'loading': (_) => const LoadingScreen()
};