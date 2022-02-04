import 'dart:async';
import 'package:flutter/material.dart';

class PreviewBloc{
  List<Widget> previewList=[];

  final widgetListController = StreamController<List<Widget>>.broadcast();
  Stream<List<Widget>> get widgetListStream => widgetListController.stream;
  StreamSink<List<Widget>> get widgetListSink => widgetListController.sink;

  final widgetListUpdateController = StreamController<Widget>.broadcast();
  StreamSink<Widget> get widgetListUpdateSink => widgetListUpdateController.sink;

  PreviewBloc()
  {
    widgetListController.add(previewList);
    widgetListUpdateController.stream.listen((event) {
      previewList.add(event);
      widgetListSink.add(previewList);
    });

  }
  void dispose()
  {
    widgetListUpdateController.close();
    widgetListController.close();
  }
}