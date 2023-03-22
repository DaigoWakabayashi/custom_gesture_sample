import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// 3 連タップを検出する GestureDetector
class TripleTapGestureDetector extends StatelessWidget {
  const TripleTapGestureDetector({
    super.key,
    required this.child,
    required this.onTripleTap,
  });

  final Widget child;
  final VoidCallback onTripleTap;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        _TripleTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_TripleTapGestureRecognizer>(
          () => _TripleTapGestureRecognizer(debugOwner: this),
          (instance) => instance.onTripleTap = onTripleTap,
        ),
      },
      child: child,
    );
  }
}

/// 3連タップを検出する GestureRecognizer
class _TripleTapGestureRecognizer extends OneSequenceGestureRecognizer {
  _TripleTapGestureRecognizer({super.debugOwner});

  // カウントダウンタイマー
  Timer? timer;
  // タップ数
  int tapCount = 0;
  // コールバック
  VoidCallback? onTripleTap;

  /// ポインタ（指）が追加された時
  @override
  void addAllowedPointer(PointerEvent event) {
    startTrackingPointer(event.pointer); // GestureArena への参加
  }

  /// ポインタ（指）のイベントを検知しハンドリング
  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      _handleDownEvent(event);
    } else if (event is PointerUpEvent) {
      _handleUpEvent(event);
    }
  }

  @override
  void dispose() {
    _stopCountdown();
    super.dispose();
  }

  /// 指が画面についた時：タイムアウトタイマーをリセットする
  void _handleDownEvent(PointerDownEvent event) {
    _resetCountdown();
  }

  /// 指が画面から離れた時：カウントアップして 3 になったらコールバックを呼び出す
  void _handleUpEvent(PointerUpEvent event) {
    tapCount++;
    if (tapCount == 3) {
      tapCount = 0;
      _stopCountdown();
      onTripleTap?.call();
    }
  }

  void _resetCountdown() {
    timer?.cancel();
    timer = Timer(kDoubleTapTimeout, () {
      tapCount = 0;
    });
  }

  void _stopCountdown() {
    timer?.cancel();
    timer = null;
  }

  @override
  void acceptGesture(int pointer) {}

  @override
  void rejectGesture(int pointer) {}

  @override
  String get debugDescription => 'Triple Tap';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
