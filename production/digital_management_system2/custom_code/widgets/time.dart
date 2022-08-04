// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
import 'dart:async';

class Time extends StatefulWidget {
  const Time({
    Key key,
    this.width,
    this.height,
    this.h,
    this.m,
    this.s,
  }) : super(key: key);

  final double width;
  final double height;
  final int h;
  final int m;
  final int s;

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  Widget build(BuildContext context) {
    final stopwatch = Stopwatch();
    stopwatch.start();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("$stopwatch.elapsedMilliseconds");
    });
    return Container();
  }
}
