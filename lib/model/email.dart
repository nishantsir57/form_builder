import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class EmailBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.email);
  String name = 'Email';
  String value = 'This is default value';
  bool required = false;
  int fontSize = 18;
  String label = '';
  bool showErrorText = false;

  buildDialog(context) {
    final key = GlobalKey();
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (ctx, setState) => AlertDialog(
                title: Text(
                  'Create Email Widget',
                  style: TextStyle(color: Colors.black),
                ),
                content: Container(
                  height: 200,
                  width: 600,
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
                          errorText: showErrorText ? 'Field is required' : null,
                          hintText: 'Enter Hint Text(required)',
                        ),
                        onChanged: (v) =>  setState(() {
                          value = v;
                          showErrorText = v.length > 0 ? false : true;
                        }),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter label Text',
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
                  SwitchListTile(
                    value: required,
                    onChanged: (newValue) => setState(() {required = newValue;}),
                    title: Text('required :'),
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      value.length > 0
                          ? previewBloc.widgetListUpdateSink.add({
                              key.toString(): _EmailBuilderWidget(
                                  value, fontSize, required, label, key)
                            })
                          : null;
                      value.length > 0 ? Navigator.of(context).pop() : null;
                      setState(() {
                        showErrorText = true;
                      });
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

class _EmailBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  bool required;
  String label;
  var key;

  _EmailBuilderWidget(
      this.value, this.fontSize, this.required, this.label, this.key);

  _EmailBuilderState createState() =>
      _EmailBuilderState(value, fontSize, required, label, key);
}

class _EmailBuilderState extends State<_EmailBuilderWidget> {
  String? value;
  String suffixValue = '@gmail.com';
  int fontSize;
  bool required;
  String newText = 'h';
  String label;
  var key;

  _EmailBuilderState(
      this.value, this.fontSize, this.required, this.label, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    return ListTile(
      title: Container(
        child: TextField(
          onChanged: (value) {
            setState(() {
              newText = value;
            });
          },
          decoration: InputDecoration(
              errorText:
                  required && newText.length <= 0 ? 'Field is required' : null,
              hintText: value,
              suffix: DropdownButton(
                value: suffixValue,
                items: [
                  '@gmail.com',
                  '@yahoo.com',
                  '@yahoo.in',
                  '@rediffmail.com'
                ]
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (String? value) {
                  suffixValue = value!;
                  setState(() {});
                },
              )),
          style: TextStyle(
            fontSize: fontSize.toDouble(),
          ),
        ),
        padding: EdgeInsets.all(10),
        width: 200,
      ),
      trailing: RaisedButton(
        onPressed: () {
          previewBloc.widgetRemoveSink.add(key.toString());
          exportBloc.codeRemoveSink.add(key.toString());
        },
        child: Text('remove'),
      ),
    );
  }

  getCode() {
    return """  
    //Email
    Container(
      child: TextField(
        onChanged: (value){
          setState(() {
          '$newText'
          });
        },
        decoration: InputDecoration(
          errorText: $required && ${newText.length} <= 0?'Field is required': null,
            hintText: $value,
            suffix: DropdownButton(
              value: $suffixValue,
              items: ['@gmail.com', '@yahoo.com', '@yahoo.in', '@rediffmail.com'].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (String? value) {
                //'$suffixValue' provide updated value to your suffix value
                setState(() {
                });
              }, 
            )
        ),
        style: TextStyle(
          fontSize: $fontSize,
        ),
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    ),
    """;
  }
}
