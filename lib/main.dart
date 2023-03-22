import 'package:custom_gesture_sample/pages/listener_page.dart';
import 'package:custom_gesture_sample/pages/single_touch_recognizer_page.dart';
import 'package:custom_gesture_sample/pages/triple_tap_gesture_recognizer_page.dart';
import 'package:custom_gesture_sample/pages/watch_arena_page.dart';
import 'package:flutter/gestures.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Switch(
              value: debugPrintGestureArenaDiagnostics,
              onChanged: (value) =>
                  setState(() => debugPrintGestureArenaDiagnostics = value),
            ),
            Switch(
              value: debugPrintRecognizerCallbacksTrace,
              onChanged: (value) =>
                  setState(() => debugPrintRecognizerCallbacksTrace = value),
            ),
            ElevatedButton(
              onPressed: () =>
                  push(context, page: const TripleTapGestureRecognizerPage()),
              child: const Text('TripleTapGestureRecognizer'),
            ),
            ElevatedButton(
              onPressed: () =>
                  push(context, page: const SingleTouchRecognizerPage()),
              child: const Text('SingleTouchRecognizer'),
            ),
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
