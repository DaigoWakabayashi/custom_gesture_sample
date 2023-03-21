import 'package:custom_gesture_sample/pages/listener_page.dart';
import 'package:custom_gesture_sample/pages/watch_arena_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () =>
                  push(context, page: const WatchGestureArenaPage()),
              child: const Text('GestureArena'),
            ),
            ElevatedButton(
              onPressed: () => push(context, page: const ListenerPage()),
              child: const Text('Listener'),
            ),
          ],
        ),
      ),
    );
  }
}

void push(BuildContext context, {required Widget page}) => Navigator.of(context)
    .push(MaterialPageRoute<void>(builder: (BuildContext context) => page));
