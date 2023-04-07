import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/users_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<User>> getUsers() async {
    try {
      final res = await http.get(Uri.parse('${Enviroment.apiBaseUrl}/users'),
          headers: {'x-token': await AuthService.getToken() ?? ''});

      final usersResponse = usersResponseFromJson(res.body);

      return usersResponse.users;
    } catch (error) {
      return [];
    }
  }
}
