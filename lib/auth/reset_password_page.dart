import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_utils.dart';
import '../components/top_curve_clipper.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  String? _message;

  Future<void> _sendResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        _message = 'パスワード再設定メールを送信しました。メールをご確認ください。';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = '送信に失敗: ${getJapaneseErrorMessage(e.code)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景のカーブ AppBar
          ClipPath(
            clipper: TopCurveClipper(),
            child: Container(
              height: 80,
              color: const Color(0xFFFF8440),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 戻るボタン
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 40),

                  // カワウソ画像
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/app_icon.png', // 画像名を適宜変更
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text('■ 登録しているメールアドレス', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'sample@example.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: _sendResetEmail,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.orange, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                      ),
                      child: const Text(
                        'メールを送信',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  if (_message != null) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        _message!,
                        style: TextStyle(
                          color: _message!.startsWith('送信に失敗') ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
