import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'pan_list_screen.dart';
import '../main.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //待ち状態のときは画面中央にアイコン表示
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return MyHomePage(); // ログイン済みならホーム画面へ
        } else {
          return LoginPage(); // 未ログインならログイン画面へ
        }
      },
    );
  }
}
