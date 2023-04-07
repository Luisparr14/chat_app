import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/loading.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/screens/users.dart';

final appRoutes = {
  'home': (_) => const UsersScreen(),
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterScreen(),
  'chat': (_) => const ChatScreen(),
  'loading': (_) => const LoadingScreen()
};