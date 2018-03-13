import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class LoadingWebpage extends StatefulWidget {
  final String pageName;

  LoadingWebpage({ @required this.pageName });

  Widget buildCompleted(BuildContext context);

  @override
  LoadingWebpageState createState() => new LoadingWebpageState();
}

class LoadingWebpageState extends State<LoadingWebpage> {
  static const double LOADING_BAR_HEIGHT = 24.0;
  static final Random _random = new Random();
  double _progress = 0.0;

  double _getProgress() {
    if (_progress >= 1.0) {
      return 1.0;
    }

    _progress = min(_progress + _random.nextDouble() / 5, 1.0);

    return _progress;
  }

  @override
  Widget build(BuildContext context) {
    if (_progress < 1.0) {
      new Future.delayed(new Duration(milliseconds: (1000 * (_random.nextDouble() * 2) + 1).floor() ))
          .whenComplete(() { setState(() {}); });

      return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.pageName),
          bottom: new PreferredSize(
              preferredSize: new Size.fromHeight(LOADING_BAR_HEIGHT),
              child: new Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: new Container(
                    height: LOADING_BAR_HEIGHT,
                    alignment: Alignment.centerLeft,
                    child: new LinearProgressIndicator(value: _getProgress()),
                  )
              )
          ),
        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.pageName)
      ),
      body: widget.buildCompleted(context),
    );
  }

}