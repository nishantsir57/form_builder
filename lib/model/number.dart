import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/view/home.dart';

class NumberBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.dialpad);
  String name = 'Number';
  String value = '';
  int fontSize = 18;
  bool required = false;
  bool showErrorText = false;

  buildDialog(context) {
    final key = GlobalKey();
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (_, setState) => AlertDialog(
                title: Text(
                  'Create Number Widget',
                  style: TextStyle(color: Colors.black),
                ),
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
                          hintText: 'Enter Hint text here',
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
                  DropdownButton(
                      value: fontSize,
                      items: [
                        1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text('$e'),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (int? value) {
                        fontSize = value!;
                        setState(() {});
                      }),
                  SwitchListTile(
                    value: required,
                    onChanged: (newValue) {
                      required = newValue;
                      setState(() {});
                    },
                    title: Text('required :'),
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      value.length > 0
                          ? previewBloc.widgetListUpdateSink.add({
                              key.toString(): _NumberBuilderWidget(
                                  value, fontSize, required, key)
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
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _NumberBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  bool required;
  var key;

  _NumberBuilderWidget(this.value, this.fontSize, this.required, this.key);

  _NumberBuilderState createState() =>
      _NumberBuilderState(value, fontSize, required, key);
}

class _NumberBuilderState extends State<_NumberBuilderWidget> {
  String? value;
  int fontSize;
  bool required;
  bool isEmpty=false;
  String text = '';
  var key;

  _NumberBuilderState(this.value, this.fontSize, this.required, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString(): getFunction()});
    return ListTile(
      title: Container(
        child: TextField(
          onChanged: (newValue) {
            isEmpty=newValue.length>0?false:true;
            text = newValue;
            setState(() {});
          },
          decoration: InputDecoration(
            errorText: required && isEmpty ? 'This field is required' : null,
            hintText: value,
          ),
          style: TextStyle(
            fontSize: fontSize.toDouble(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        padding: EdgeInsets.all(10),
        width: 200,
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

  getCode() {
    return """
    //Number
    getNumber(value, fontSize, required, isEmpty)
    {
      return Container(
        child: TextField(
          onChanged: (newValue) {
            isEmpty=newValue.length>0?false:true;
            text = newValue;
            setState(() {});
          },
          decoration: InputDecoration(
            errorText: required && isEmpty ? 'This field is required' : null,
            hintText: value,
          ),
          style: TextStyle(
            fontSize: fontSize.toDouble(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        padding: EdgeInsets.all(10),
        width: 200,
      );
    }
    """;
  }

  getFunction() {
    return "getNumber('$value', $fontSize, $required, false),\n";
  }
}
