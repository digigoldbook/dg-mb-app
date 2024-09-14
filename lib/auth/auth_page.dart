import 'package:flutter/material.dart';

import '../main_screen/pages/main_page.dart';
import '../welcome_screen/pages/wel_come_page.dart';
import 'sign_in/hive/token_storage.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<String?> _checkAuthStatus() async {
    final accessToken = await TokenStorage.getAccessToken();
    return accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _checkAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle errors here
            return const Center(child: Text('An error occurred'));
          } else if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const WelComePage();
          }
        },
      ),
    );
  }
}
