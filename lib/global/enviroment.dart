import 'dart:io';

class Enviroment {
  static String apiBaseUrl() => Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://localhost:3000/api';

  static String socketBaseUrl() => Platform.isAndroid
      ? 'http://10.0.2.2:3000'
      : 'http://localhost:3000';
}
