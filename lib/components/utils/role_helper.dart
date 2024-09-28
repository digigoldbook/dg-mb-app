import 'package:jwt_decoder/jwt_decoder.dart';

import '../../auth/sign_in/hive/retrive_token.dart';

class RoleHelper {
  static Future<String?> getUserRole() async {
    List<String?> tokens = await retriveToken();
    String? accessToken = tokens[0];
    if (accessToken!.isNotEmpty) {
      Map<String, dynamic>? decodedToken = JwtDecoder.decode(accessToken);
      return decodedToken['role'];
    }
    return null;
  }

  static Future<bool> isUserAdmin() async {
    String? role = await getUserRole();
    return role == 'admin';
  }
}
