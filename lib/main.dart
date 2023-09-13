import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer/next_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'タイマー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _second = 0;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_second',
              style: TextStyle(fontSize: 100),
            ),
            ElevatedButton(
                onPressed: () {
                  toggleTimer();
                },
                child: Text(
                  _isRunning ? 'ストップ' : 'スタート',
                  style: TextStyle(
                    color: _isRunning ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            ElevatedButton(
                onPressed: () {
                  resetTimer();
                },
                child: const Text(
                  'リセット',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if(_isRunning) {
      _timer?.cancel();
    }else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
            (timer) {
          setState(() {
            _second++;
          });

          if (_second == 10) {
            resetTimer();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NextPage()),
            );
          }
        },
      );
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _second = 0;
      _isRunning = false;
    });
  }
}
