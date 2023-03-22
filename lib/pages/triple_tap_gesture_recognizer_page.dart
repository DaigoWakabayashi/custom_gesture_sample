import 'dart:developer';

import 'package:custom_gesture_sample/widgets/triple_tap_gesture_detector.dart';
import 'package:flutter/material.dart';

class TripleTapGestureRecognizerPage extends StatelessWidget {
  const TripleTapGestureRecognizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(runtimeType.toString())),
      body: TripleTapGestureDetector(
        onTripleTap: () => log('onTripleTap called!'),
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
