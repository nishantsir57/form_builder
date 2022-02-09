import 'dart:async';

class ExportBloc {
  Map<String, String> codeMap = {};
  Map<String, String> functionMap = {};
  Map<String, dynamic> variablesMap = {};

  final codeController = StreamController<Map<String, String>>.broadcast();
  final functionController = StreamController<Map<String, String>>.broadcast();
  final variableController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, String>> get codeStream => codeController.stream;
  StreamSink<Map<String, String>> get codeSink => codeController.sink;

  Stream<Map<String, String>> get functionStream => functionController.stream;
  StreamSink<Map<String, String>> get functionSink => functionController.sink;

  Stream<Map<String, dynamic>> get variableStream => variableController.stream;
  StreamSink<Map<String, dynamic>> get variableSink => variableController.sink;

  final codeUpdateController =
    StreamController<Map<String, String>>.broadcast();
  StreamSink<Map<String, String>> get codeUpdateSink =>
      codeUpdateController.sink;

  final codeRemoveController = StreamController<String>.broadcast();
  StreamSink<String> get codeRemoveSink => codeRemoveController.sink;

  final functionUpdateController =
  StreamController<Map<String, String>>.broadcast();
  StreamSink<Map<String, String>> get functionUpdateSink =>
      functionUpdateController.sink;

  final functionRemoveController = StreamController<String>.broadcast();
  StreamSink<String> get functionRemoveSink => functionRemoveController.sink;


  final variableUpdateController =
  StreamController<Map<String, dynamic>>.broadcast();
  StreamSink<Map<String, dynamic>> get variableUpdateSink =>
      variableUpdateController.sink;

  final variableRemoveController = StreamController<String>.broadcast();
  StreamSink<String> get variableRemoveSink => variableRemoveController.sink;


  ExportBloc() {
    codeController.add(codeMap);
    codeUpdateController.stream.listen((event) {
      codeMap[event.keys.elementAt(0)] = event.values.elementAt(0);
      codeSink.add(codeMap);
    });
    codeRemoveController.stream.listen((event){
      codeMap.remove(event);
      codeSink.add(codeMap);
    });

    functionController.add(functionMap);
    functionUpdateController.stream.listen((event) {
      functionMap[event.keys.elementAt(0)] = event.values.elementAt(0);
      functionSink.add(functionMap);
    });
    functionRemoveController.stream.listen((event){
      functionMap.remove(event);
      functionSink.add(codeMap);
    });

    variableController.add(variablesMap);
    variableUpdateController.stream.listen((event) {
      variablesMap[event.keys.elementAt(0)] = event.values.elementAt(0);
      variableSink.add(functionMap);
    });
    variableRemoveController.stream.listen((event){
      variablesMap.remove(event);
      variableSink.add(codeMap);
    });
  }

  void dispose() {
    codeRemoveController.close();
    codeUpdateController.close();
    codeController.close();
    functionController.close();
    functionUpdateController.close();
    functionRemoveController.close();
    variableController.close();
    variableUpdateController.close();
    variableRemoveController.close();
  }

  generateCode() {
    String code='';
    String function='';
    String variables='';
    for (String s in codeMap.values)
      code+=s;
    for(String s in functionMap.values)
      function+=s;
    for(dynamic d in variablesMap.values) {
      for(var v in d)
        {
          variables+='$v\n';
        }
    }
    return """
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {
  $variables
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),);}
_buildBody() {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(padding: EdgeInsets.fromLTRB(30, 30, 30, 60),color: Color(0xffedebe6),child: createPreviewPage(),);
  }
  createPreviewPage()
  {
    return ListView(
    children:[$function]);
    }
    $code}
    """;
  }
}
