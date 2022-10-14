import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Multiple Gestures Demo', home: DemoApp());
  }
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(),
          (AllowMultipleGestureRecognizer instance) {
            instance.onTap =
                () => debugPrint('It is the parent container gesture');
          },
        )
      },
      behavior: HitTestBehavior.opaque,
      //Parent Container
      child: Container(
        color: Colors.green,
        child: Center(
          //Now, wraps the second container in RawGestureDetector
          child: RawGestureDetector(
            gestures: {
              AllowMultipleGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      AllowMultipleGestureRecognizer>(
                () => AllowMultipleGestureRecognizer(), //constructor
                (AllowMultipleGestureRecognizer instance) {
                  //initializer
                  instance.onTap =
                      () => debugPrint('It is the nested container');
                },
              )
            },
            //Creates the nested container within the first.
            child: Container(
              color: Colors.deepOrange,
              width: 250.0,
              height: 350.0,
            ),
          ),
        ),
      ),
    );
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
