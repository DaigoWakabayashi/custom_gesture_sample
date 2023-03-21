import 'dart:developer';

import 'package:flutter/material.dart';

class ListenerPage extends StatefulWidget {
  const ListenerPage({super.key});

  @override
  State<ListenerPage> createState() => _ListenerPageState();
}

class _ListenerPageState extends State<ListenerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListenerPage')),

      /// Listener ウィジェットで生のポインタイベントを logging
      body: const Listener(
        onPointerDown: _logEvent,
        onPointerMove: _logEvent,
        onPointerUp: _logEvent,
        child: ColoredBox(
          color: Colors.red,
          child: SizedBox.expand(),
        ),
      ),
    );
  }
}

/// Pointer → 一意の識別子（スマホの場合は「画面に触れた指の ID」にあたる）
/// Position → イベントが発生している Offset（画面左上を 0,0 とした座標）
void _logEvent(PointerEvent event) => log(
      'type: ${event.runtimeType} | Pointer: ${event.pointer} | Position: ${event.position} | ${event.timeStamp}',
    );
