import 'dart:async';
import 'package:flutter/material.dart';
class WidgetBloc{
  List<Widget> widgetBuilderList=[];

  final widgetBuilderListController = StreamController<List<Widget>>.broadcast();
  Stream<List<Widget>> get widgetBuilderListStream => widgetBuilderListController.stream;
  StreamSink<List<Widget>> get widgetBuilderListSink => widgetBuilderListController.sink;

  final widgetBuilderListUpdateController = StreamController<Widget>.broadcast();
  StreamSink<Widget> get widgetBuilderListUpdateSink => widgetBuilderListUpdateController.sink;

  WidgetBloc()
  {
    widgetBuilderListController.add(widgetBuilderList);
    widgetBuilderListUpdateController.stream.listen((event) {
      widgetBuilderList.add(event);
      widgetBuilderListSink.add(widgetBuilderList);
    });
  }
  void dispose()
  {
    widgetBuilderListUpdateController.close();
    widgetBuilderListController.close();
  }
}