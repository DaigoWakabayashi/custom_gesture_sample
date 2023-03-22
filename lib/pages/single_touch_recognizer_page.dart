import 'dart:developer';

import 'package:custom_gesture_sample/widgets/single_touch_scope.dart';
import 'package:flutter/material.dart';

class SingleTouchRecognizerPage extends StatelessWidget {
  const SingleTouchRecognizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(runtimeType.toString())),
      body: SingleTouchScope(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => log('A pressed!'),
                child: const Text('A ボタン'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => log('B pressed!'),
                child: const Text('B ボタン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
