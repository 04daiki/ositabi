import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pan_list_screen.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return PanListScreen(); // ログイン済みならパン一覧画面へ
        } else {
          return LoginPage(); // 未ログインならログイン画面へ
        }
      },
    );
  }
}
