import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
late final DateTime startedAt;

String runtime() => DateTime.now().difference(startedAt).toString();

void main() {
  startedAt = DateTime.now();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _singleTaps = true;
  bool _doubleTaps = true;
  bool _pans = true;
  bool _longPresses = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Click anywhere and check the logs!',
              style: TextStyle(color: darkBlue)),
          backgroundColor: Colors.white,
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Positioned(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: VerboseGestureDetector(
                    listenDouble: _doubleTaps,
                    listenSingle: _singleTaps,
                    listenPans: _pans,
                    listenLongPress: _longPresses,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 200,
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Listen to single taps?'),
                              Checkbox(
                                onChanged: (bool? newVal) => setState(
                                    () => _singleTaps = newVal ?? false),
                                value: _singleTaps,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Listen to double taps?'),
                              Checkbox(
                                onChanged: (bool? newVal) => setState(
                                    () => _doubleTaps = newVal ?? false),
                                value: _doubleTaps,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Listen to long presses?'),
                              Checkbox(
                                onChanged: (bool? newVal) => setState(
                                    () => _longPresses = newVal ?? false),
                                value: _longPresses,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Listen to pans?'),
                              Checkbox(
                                onChanged: (bool? newVal) =>
                                    setState(() => _pans = newVal ?? false),
                                value: _pans,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VerboseGestureDetector extends StatelessWidget {
  const VerboseGestureDetector({
    super.key,
    required this.listenSingle,
    required this.listenDouble,
    required this.listenPans,
    required this.listenLongPress,
  });

  final bool listenSingle;
  final bool listenDouble;
  final bool listenPans;
  final bool listenLongPress;

  @override
  Widget build(BuildContext context) {
    GestureTapDownCallback? onTapDown;
    GestureTapCallback? onTap;
    GestureTapUpCallback? onTapUp;

    GestureDragUpdateCallback? onPanUpdate;

    GestureTapDownCallback? onDoubleTapDown;
    GestureTapCallback? onDoubleTap;
    GestureTapCancelCallback? onDoubleTapCancel;

    GestureLongPressCallback? onLongPress;
    GestureLongPressStartCallback? onLongPressStart;

    if (listenSingle) {
      onTapDown = (TapDownDetails details) {
        // onTapDown always* fires, even if the TapGestureRecognizer does not
        // emerge victorious from the Gesture Arena. For this reason, do not
        // put code in here that should be circumvented by a double-click or
        // a long press.
        //
        // onTapDown technically only ALMOST always fires, because specific
        // scenarios like a very-fast double tap can be recognized quickly
        // enough that onTapDown is never called.
        print('[TAP DOWN] ${details.localPosition} @ ${runtime()}');
      };
      onTap = () {
        // onTap only fires if the TapGestureRecognizer emerges victorious from
        // the Gesture Arena, so it is safe to put code here that should NOT
        // run if the user is actually halfway en-route to a double click.
        print('[TAP] @ ${runtime()}');
      };
      onTapUp = (TapUpDetails details) {
        // onTapUp is less frequently used, but always fires, even if the
        // TapGestureRecognizer does not emerge victorious from the Gesture
        // Arena. For this reason, do not put code in here that should be
        // circumvented by a double-click or a long press.
        print('[TAP UP] ${details.localPosition} @ ${runtime()}');
      };
    }

    if (listenPans) {
      onPanUpdate = (DragUpdateDetails details) {
        print('[PAN UPDATE] ${details.localPosition} @ ${runtime()}');
      };
    }

    if (listenDouble) {
      onDoubleTapDown = (TapDownDetails details) {
        // onTapDown always fires, even if the TapGestureRecognizer does not
        // emerge victorious from the Gesture Arena. For this reason, do not
        // put code in here that should be circumvented by a double-click or
        // a long press.
        print('[DOUBLE TAP DOWN] ${details.localPosition} @ ${runtime()}');
      };
      onDoubleTap = () {
        // onTap only fires if the TapGestureRecognizer emerges victorious from
        // the Gesture Arena, so it is safe to put code here that should NOT
        // run if the user is actually halfway en-route to a double click.
        print('[DOUBLE TAP] @ ${runtime()}');
      };
      onDoubleTapCancel = () {
        // Fired when a potential double tap concedes defeat within the
        // Gesture Arena.
        print('[DOUBLE TAP CANCEL] @ ${runtime()}');
      };
    }

    if (listenLongPress) {
      onLongPress = () {
        print('[LONGPRESS] @ ${runtime()}');
      };
      onLongPressStart = (LongPressStartDetails details) {
        print('[LONGPRESS START] @ ${runtime()}');
      };
    }

    return GestureDetector(
      // [SINGLE-TAP]
      onTapDown: onTapDown,
      onTap: onTap,
      onTapUp: onTapUp,
      // [DOUBLE-TAP]
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTap: onDoubleTap,
      onDoubleTapCancel: onDoubleTapCancel,
      // [LONG-PRESS]
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      // [PAN]
      onPanUpdate: onPanUpdate,
    );
  }
}
