import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase 初期化用
import 'pan_list_screen.dart'; // パン一覧画面

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase を初期化
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const を追加

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(), // const を追加
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // const を追加

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // カウントアップ処理
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // パン一覧画面へ遷移
  void _goToPanList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PanListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many timesあああ:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToPanList,
              child: const Text('パン一覧を見る'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
