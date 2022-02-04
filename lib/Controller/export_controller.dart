import 'dart:async';

class ExportBloc{
  String codeData='';
  String startData="""
  ListView(
     children: [
              
  """;
  String endData="""
]);
  """;
  final codeController = StreamController<String>.broadcast();
  Stream<String> get codeStream => codeController.stream;
  StreamSink<String> get codeSink => codeController.sink;

  final codeUpdateController = StreamController<String>.broadcast();
  StreamSink<String> get codeUpdateSink => codeUpdateController.sink;

  ExportBloc()
  {
    codeController.add(codeData);
    codeUpdateController.stream.listen((event) {
      codeData+=event;
      codeSink.add(startData+codeData+endData);
    });

  }
  void dispose()
  {
    codeUpdateController.close();
    codeController.close();
  }
}