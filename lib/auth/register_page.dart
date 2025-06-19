import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<bool?> _showConfirmDialog() async {
    return showDialog<bool>(
      context: context, //どこの画面で表示するか
      builder: (context) => AlertDialog(
        title: const Text('確認'),
        content: Text(
          '以下の内容で登録しますか？\n\nメールアドレス: ${_emailController.text.trim()}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('登録する'),
          ),
        ],
      ),
    );
  }

  Future<void> _register() async {
    final confirmed = await _showConfirmDialog();
    if (confirmed != true) return; // キャンセルされたら中止

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // 登録後に認証メールを送信
      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        // 案内ダイアログを表示
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('確認メールを送信しました'),
            content: const Text('登録したメールアドレス宛に確認メールを送りました。メール内のリンクをクリックして認証してください。'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // RegisterPageから戻る
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = getJapaneseErrorMessage(e.code);
      });
    }catch (e) {
      setState(() {
        _errorMessage = '登録に失敗しました: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新規登録')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_errorMessage != null) ...[
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
            ],
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'パスワード'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register,
              child: const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
