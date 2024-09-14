class SignInResponseModel {
  final String accessToken;
  final String refreshToken;

  SignInResponseModel({required this.accessToken, required this.refreshToken});

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    return SignInResponseModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
