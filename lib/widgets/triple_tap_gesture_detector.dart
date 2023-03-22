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
  final GestureTapCallback onTripleTap;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        TripleTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TripleTapGestureRecognizer>(
          () => TripleTapGestureRecognizer(debugOwner: this),
          (instance) => instance.onTripleTap = onTripleTap,
        ),
      },
      child: child,
    );
  }
}

/// 3連タップを検出する GestureRecognizer
class TripleTapGestureRecognizer extends GestureRecognizer {
  TripleTapGestureRecognizer({super.debugOwner});

  Timer? timer;
  int tapCount = 0;

  VoidCallback? onTripleTap;

  /// ポインタ（指）が追加された時、ルートの GestureBinding に
  @override
  void addAllowedPointer(PointerEvent event) {
    GestureBinding.instance.pointerRouter.addRoute(
      event.pointer,
      (event) {
        if (event is PointerDownEvent) {
          _processPointerDownEvent(event);
        } else if (event is PointerUpEvent) {
          _processPointerUpEvent(event);
        }
      },
      event.transform,
    );
  }

  @override
  void dispose() {
    _stopCountdown();
    super.dispose();
  }

  /// 指が画面についた時：タイムアウトタイマーをリセットする
  void _processPointerDownEvent(PointerDownEvent event) {
    _resetCountdown();
  }

  /// 指が画面から離れた時：カウントアップして 3 になったらコールバックを呼び出す
  void _processPointerUpEvent(PointerUpEvent event) {
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
}
