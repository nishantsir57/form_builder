import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class ButtonBuilder extends StatelessWidget
{
  Icon icon = Icon(Icons.smart_button);
  String name = 'Button';
  var showErrorText=false;
  var value='';

  buildDialog(context)
  {
    final key=GlobalKey();
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (_, setState)=> AlertDialog(
              title: Text('Create Button', style: TextStyle(color: Colors.black),),
              content: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Colors.white,
                          spreadRadius: 20,
                          blurStyle: BlurStyle.solid)
                    ]),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        errorText:
                        showErrorText ? 'Hint Text(required)' : null,
                        hintText: 'Enter Button value here',
                      ),
                      onChanged: (v) => setState(() {
                        value = v;
                        showErrorText = v.length > 0 ? false : true;
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    value.length > 0
                        ? previewBloc.widgetListUpdateSink.add({
                      key.toString(): _ButtonWidget(key, value)
                    })
                        : Container();
                    value.length > 0
                        ? setState(() {
                      value = '';
                      Navigator.of(context).pop();
                    })
                        : {
                      setState(() {
                        showErrorText = true;
                      })
                    };
                  },
                )
              ],
            )
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class _ButtonWidget extends StatefulWidget
{
  var key;
  var buttonText;
  _ButtonWidget(this.key, this.buttonText);
  _ButtonState createState() => _ButtonState(key, buttonText);
}
class _ButtonState extends State<_ButtonWidget>
{
  var key;
  var buttonText;
  _ButtonState(this.key, this.buttonText);
  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString(): getFunction()});
    return ListTile(
      title: Container(
        width: 100,
        padding: EdgeInsets.fromLTRB(200, 20, 200, 20),
        child: RaisedButton(
          color: Colors.blue,
          onPressed: onPressed,
          child: Text(buttonText, style: TextStyle(color: Colors.white),),
          padding: EdgeInsets.all(10),

        ),
      ),
      trailing: RaisedButton(
        onPressed: () {
          previewBloc.widgetRemoveSink.add(key.toString());
          exportBloc.codeRemoveSink.add(key.toString());
          exportBloc.functionRemoveSink.add(key.toString());
        },
        child: Text('remove'),
      ),
    );
  }
  onPressed(){print('hello');}

  getCode()
  {
    return """
      getButton(buttonText)
      {
        return Container(
        padding: EdgeInsets.fromLTRB(200, 20, 200, 20),
        child: RaisedButton(
        color: Colors.blue,
          onPressed: onPressed,
          child: Text(buttonText, style: TextStyle(color: Colors.white),),
          padding: EdgeInsets.all(10),),);
      }
      onPressed(){}
    """;
  }
  getFunction()
  {
    return """
      getButton('$buttonText'),
    """;
  }

}