// lib/pan_list_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PanListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('パン一覧')),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection('pan').snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) return Center(child: Text('エラーが発生しました'));
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }

      //     final docs = snapshot.data!.docs;

      //     return ListView.builder(
      //       itemCount: docs.length,
      //       itemBuilder: (context, index) {
      //         final data = docs[index].data() as Map<String, dynamic>;
      //         final name = data['name'] ?? '名前なし';
      //         final price = data['price'] ?? '価格不明';

      //         return ListTile(
      //           leading: Icon(Icons.local_dining),
      //           title: Text(name),
      //           subtitle: Text('価格: ¥$price'),
      //         );
      //       },
      //     );
      //   },
      // ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
