import 'token_storage.dart';

Future<List<String?>> retriveToken() async {
  final accessToken = await TokenStorage.getAccessToken();
  final refreshToken = await TokenStorage.getRefreshToken();

  return [accessToken, refreshToken];
}
