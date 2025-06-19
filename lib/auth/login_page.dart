import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!credential.user!.emailVerified) {
        await FirebaseAuth.instance.signOut(); // 強制ログアウト

        setState(() {
          _errorMessage = 'メールアドレスが未確認です。確認メールをチェックしてください。';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = getJapaneseErrorMessage(e.code);
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ログインに失敗しました';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null) ...[
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 8),
            ],
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'メールアドレス'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('ログイン'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('新規登録はこちら'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset');
              },
              child: const Text('パスワードを忘れたときはこちら'),
            ),
          ],
        ),
      ),
    );
  }
}
