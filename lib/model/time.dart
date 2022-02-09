import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TimeBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.timer);
  String name = 'Time';

  buildDialog(context) {
    final key = GlobalKey();
    previewBloc.widgetListUpdateSink
        .add({key.toString(): _TimeBuilderWidget(key)});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _TimeBuilderWidget extends StatefulWidget {
  var key;

  _TimeBuilderWidget(this.key);

  _TimeBuilderState createState() => _TimeBuilderState(key);
}

class _TimeBuilderState extends State<_TimeBuilderWidget> {
  var key;

  _TimeBuilderState(this.key);

  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    exportBloc.variableUpdateSink.add({key.toString(): ['var time = TimeOfDay.now();']});
    return ListTile(
      title: Container(
        alignment: Alignment.center,
        child: ListTile(
          title: time.hour < 12
              ? Text(
                  '${time.hour}:${time.minute} ${time.period.name.toUpperCase()}')
              : Text(
                  '${time.hour - 12}:${time.minute} ${time.period.name.toUpperCase()}'),
          leading: Icon(Icons.timer),
          onTap: () async {
            time = (await showTimePicker(context: context, initialTime: time))!;
            setState(() {});
          },
        ),
      ),
      trailing: RaisedButton(
        onPressed: () {
          previewBloc.widgetRemoveSink.add(key.toString());
          exportBloc.codeRemoveSink.add(key.toString());
          exportBloc.functionRemoveSink.add(key.toString());
          exportBloc.variableRemoveSink.add(key.toString());
        },
        child: Text('Remove'),
      ),
    );
  }

  getCode() {
    return """

    //Time Picker
     getTime()
     {
      return ListTile(
      title: Container(
        alignment: Alignment.center,
        child: ListTile(
          title: time.hour < 12
              ? Text(
                  '\${time.hour}:\${time.minute} \${time.period.name.toUpperCase()}')
              : Text(
                  '\${time.hour - 12}:\${time.minute} \${time.period.name.toUpperCase()}'),
          leading: Icon(Icons.timer),
          onTap: () async {
            time = (await showTimePicker(context: context, initialTime: time))!;
            setState(() {});
          },
        ),
      ),
    );
     }
    """;
  }
  getFunction()
  {
    return "getTime(),\n";
  }
}
