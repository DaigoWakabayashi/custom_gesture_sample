import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 小領域を単一タップしか受け付けなくする Widget.

class SingleTouchScope extends StatelessWidget {
  const SingleTouchScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        _SingleTouchRecognizer:
            GestureRecognizerFactoryWithHandlers<_SingleTouchRecognizer>(
          () => _SingleTouchRecognizer(),
          (_) {},
        )
      },
      child: child,
    );
  }
}

/// 複数ポインタの同時押しを禁止する Recognizer.
/// child 内にある Recognizer とタップイベントの勝負をして、
/// 1 本目の指だったら確実に 子 のタップイベントを勝利させ
/// 2 本目以降の指だったら確実にタップイベントを奪い無効化する
class _SingleTouchRecognizer extends OneSequenceGestureRecognizer {
  // 指（ポインタ）の識別子
  int _p = 0;

  /// 押下イベントが発生したときに呼ばれる
  /// event.pointer(int) にはアプリ内で一意な番号が割り振られている
  @override
  void addAllowedPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer); // GestureArena への参加
    if (_p == 0) {
      // 1本目の指が押下された時
      resolve(GestureDisposition.rejected); // 敗北宣言を出し、競合したタップイベントを優先させる
      _p = event.pointer;
    } else {
      // 2本目以降の指が押下された時
      resolve(GestureDisposition.accepted); // 勝利宣言を出し、競合したタップイベントを奪う
    }
  }

  /// 追跡中のポインタ内で発生したイベント（タップダウン・タップアップ・スライド等）ごとに呼び出される
  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      // 指が画面から離れたとき、独自ポインタ（_p）を 0 にリセット
      _p = 0;
    }
  }

  @override
  String get debugDescription => runtimeType.toString();

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
