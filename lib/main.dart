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
  int _millisecond = 0;
  int _second = 0;
  int _minute = 0;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _minute.toString().padLeft(2, '0').substring(0, 2),
                  style: const TextStyle(fontSize: 80),
                ),
                const Text(
                  '.',
                  style: TextStyle(fontSize: 80),
                ),
                Text(
                  _second.toString().padLeft(2, '0').substring(0, 2),
                  style: const TextStyle(fontSize: 80),
                ),
                const Text(
                  '.',
                  style: TextStyle(fontSize: 80),
                ),
                Text(
                  _millisecond.toString().padLeft(3, '0').substring(0, 2),
                  style: const TextStyle(fontSize: 80),
                ),
              ],
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
                )),
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
                )),
          ],
        ),
      ),
    );
  }

  void toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(
        const Duration(milliseconds: 0),
        (timer) {
          setState(() {
            _millisecond++;
          });

          if (_millisecond % 1000 == 0) {
            _second++;
            _millisecond = 0;
          }

          if (_second == 60) {
            _minute++;
            _second = 0;
          }

          if (_minute == 2) {
            resetTimer();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NextPage()),
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
      _millisecond = 0;
      _second = 0;
      _minute = 0;
      _isRunning = false;
    });
  }
}
