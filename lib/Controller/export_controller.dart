import 'dart:async';

class ExportBloc {
//   String codeData='';
//   String startData="""
//   ListView(
//      children: [
//
//   """;
//   String endData="""
// ]);
//   """;
  Map<String, String> codeMap = {};
  final codeController = StreamController<Map<String, String>>.broadcast();

  Stream<Map<String, String>> get codeStream => codeController.stream;

  StreamSink<Map<String, String>> get codeSink => codeController.sink;

  final codeUpdateController =
      StreamController<Map<String, String>>.broadcast();

  StreamSink<Map<String, String>> get codeUpdateSink =>
      codeUpdateController.sink;

  final codeRemoveController = StreamController<String>.broadcast();

  StreamSink<String> get codeRemoveSink => codeRemoveController.sink;

  ExportBloc() {
    codeController.add(codeMap);
    codeUpdateController.stream.listen((event) {
      codeMap[event.keys.elementAt(0)] = event.values.elementAt(0);
      codeSink.add(codeMap);
    });
    codeRemoveController.stream.listen((event) {
      codeMap.remove(event);
      codeSink.add(codeMap);
    });
  }

  void dispose() {
    codeRemoveController.close();
    codeUpdateController.close();
    codeController.close();
  }
}
