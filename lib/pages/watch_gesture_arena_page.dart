import 'dart:developer';

import 'package:flutter/material.dart';

class WatchGestureArenaPage extends StatelessWidget {
  const WatchGestureArenaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WatchGestureArenaPage')),
      body: GestureDetector(
        onTap: () => log('onTap called!'),
        onDoubleTap: () => log('onDoubleTap called!'),
        onLongPress: () => log('onLongPress called!'),
        child: const ColoredBox(
          color: Colors.red,
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}
