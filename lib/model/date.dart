import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class DateBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.date_range_outlined);
  String name = 'Date';

  buildDialog(context) {
    final key = GlobalKey();
    previewBloc.widgetListUpdateSink
        .add({key.toString(): _DateBuilderWidget(key)});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DateBuilderWidget extends StatefulWidget {
  var key;

  _DateBuilderWidget(this.key);

  _DateBuilderState createState() => _DateBuilderState(key);
}

class _DateBuilderState extends State<_DateBuilderWidget> {
  var key;
  _DateBuilderState(this.key);
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    return Container(
      alignment: Alignment.center,
      child: ListTile(
        title: Text('${date.day}/${date.month}/${date.year}'),
        leading: Icon(Icons.date_range_outlined),
        onTap: () async {
          date = (await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1955),
              lastDate: DateTime(2030)))!;
          setState(() {});
        },
        trailing: RaisedButton(
          onPressed: () {
            previewBloc.widgetRemoveSink.add(key.toString());
            exportBloc.codeRemoveSink.add((key.toString()));
          },
          child: Text('remove'),
        ),
      ),
    );
  }

  getCode() {
    return """
    
    //Date Picker
    Container(
      alignment: Alignment.center,
      child: ListTile(
        title: Text('${date.day}/${date.month}/${date.year}'),
        leading: Icon(Icons.date_range_outlined),
        onTap: ()async{
          date=(await showDatePicker(
              context: context,
              initialDate: $date,
              firstDate: DateTime(1955),
              lastDate: DateTime(2030)
          ))!;
          setState(() {
          });
        },
      ),
    ),
    """;
  }
}
