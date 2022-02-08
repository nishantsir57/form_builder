import 'dart:async';

import 'package:flutter/material.dart';

class PreviewBloc {
  Map<String, Widget> previewList = {
    'header': ListTile(
      title: Text(
        'Form Section 1',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      subtitle: Container(height: 1, color: Colors.black),
    )
  };

  final widgetListController =
      StreamController<Map<String, Widget>>.broadcast();

  Stream<Map<String, Widget>> get widgetListStream =>
      widgetListController.stream;

  StreamSink<Map<String, Widget>> get widgetListSink =>
      widgetListController.sink;

  final widgetListUpdateController =
      StreamController<Map<String, Widget>>.broadcast();

  StreamSink<Map<String, Widget>> get widgetListUpdateSink =>
      widgetListUpdateController.sink;

  final widgetRemoveController = StreamController<String>();

  StreamSink<String> get widgetRemoveSink => widgetRemoveController.sink;

  PreviewBloc() {
    widgetListController.add(previewList);
    widgetListUpdateController.stream.listen((event) {
      previewList[event.keys.elementAt(0)] = event.values.elementAt(0);
      widgetListSink.add(previewList);
    });
    widgetRemoveController.stream.listen((event) {
      previewList.remove(event);
      widgetListSink.add(previewList);
    });
  }

  void dispose() {
    widgetListUpdateController.close();
    widgetListController.close();
    widgetRemoveController.close();
  }
}
