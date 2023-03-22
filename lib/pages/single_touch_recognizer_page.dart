import 'dart:developer';

import 'package:custom_gesture_sample/widgets/single_touch_recognizer.dart';
import 'package:flutter/material.dart';

class SingleTouchRecognizerPage extends StatelessWidget {
  const SingleTouchRecognizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(runtimeType.toString())),
      body: RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          SingleTouchRecognizer:
              GestureRecognizerFactoryWithHandlers<SingleTouchRecognizer>(
            () => SingleTouchRecognizer(),
            (_) {},
          )
        },
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => log('A pressed!'),
              child: const Text('A ボタン'),
            ),
            ElevatedButton(
              onPressed: () => log('B pressed!'),
              child: const Text('B ボタン'),
            ),
          ],
        ),
      ),
    );
  }
}
