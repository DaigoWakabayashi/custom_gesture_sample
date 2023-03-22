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
          () => TripleTapGestureRecognizer(),
          (TripleTapGestureRecognizer instance) {
            instance.onTripleTap = onTripleTap;
          },
        ),
      },
      child: child,
    );
  }
}

/// 3連タップを検出する GestureRecognizer
class TripleTapGestureRecognizer extends GestureRecognizer {
  Timer? countdown;
  int tapCounter = 0;
  Duration countdownDuration = const Duration(milliseconds: 500);

  VoidCallback? onTripleTap;

  @override
  void addAllowedPointer(PointerEvent event) {
    GestureBinding.instance.pointerRouter.addRoute(
      event.pointer,
      _handleEvent,
      event.transform,
    );
  }

  @override
  void acceptGesture(int pointer) {}

  @override
  void rejectGesture(int pointer) {}

  @override
  String get debugDescription => 'Triple Tap';

  @override
  void dispose() {
    _stopCountdown();
    super.dispose();
  }

  void _handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      _processPointerDownEvent(event);
    } else if (event is PointerUpEvent) {
      _processPointerUpEvent(event);
    }
  }

  void _processPointerDownEvent(PointerDownEvent event) {
    _resetCountdown();
  }

  void _processPointerUpEvent(PointerUpEvent event) {
    tapCounter++;
    if (tapCounter == 3) {
      _resetCounter();
      _stopCountdown();
      onTripleTap?.call();
    }
  }

  void _resetCountdown() {
    countdown?.cancel();
    countdown = Timer(countdownDuration, () {
      tapCounter = 0;
    });
  }

  void _resetCounter() {
    tapCounter = 0;
  }

  void _stopCountdown() {
    countdown?.cancel();
    countdown = null;
  }
}
