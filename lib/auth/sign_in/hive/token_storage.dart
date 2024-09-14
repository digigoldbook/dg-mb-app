import 'package:hive/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenStorage {
  static const String _boxName = 'tokenBox';

  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    final box = await Hive.openBox(_boxName);
    await box.put('accessToken', accessToken);
    await box.put('refreshToken', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get('accessToken');
  }

  static Future<String?> getRefreshToken() async {
    final box = await Hive.openBox(_boxName);
    return box.get('refreshToken');
  }

  static Future<void> clearTokens() async {
    final box = await Hive.openBox(_boxName);
    await box.delete('accessToken');
    await box.delete('refreshToken');
  }

  static Future<Map<String, dynamic>?> decodeAccessToken() async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      return JwtDecoder.decode(accessToken);
    }
    return null;
  }
}
