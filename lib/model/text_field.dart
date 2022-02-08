import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TextFieldBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.text_fields);
  String name = 'Text Field';
  String value = '';
  int fontSize = 18;
  bool required = false;

  var showErrorText = false;

  buildDialog(context) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (_, setState) => AlertDialog(
                title: Text(
                  'Create Text Widget',
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
                              showErrorText ? 'This field is required' : null,
                          hintText: 'Enter Hint Text(required)',
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
                        1,
                        2,
                        4,
                        6,
                        8,
                        10,
                        12,
                        14,
                        16,
                        18,
                        20,
                        22,
                        24,
                        26,
                        28,
                        30,
                        32,
                        34,
                        36,
                        38,
                        40,
                        42,
                        44,
                        46,
                        48,
                        50
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
                              key.toString(): _TextFieldBuilderWidget(
                                  value, fontSize, required, key)
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

class _TextFieldBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  bool required;
  var key;

  _TextFieldBuilderWidget(this.value, this.fontSize, this.required, this.key);

  _TextFieldBuilderState createState() =>
      _TextFieldBuilderState(value, fontSize, required, key);
}

class _TextFieldBuilderState extends State<_TextFieldBuilderWidget> {
  String? value;
  int fontSize;
  String textValue = 'This is default value';
  bool required;
  var key;

  _TextFieldBuilderState(this.value, this.fontSize, this.required, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    return Row(
      children: [
        TextField(
          onChanged: (newValue) {
            textValue = newValue;
            setState(() {});
          },
          decoration: InputDecoration(
              errorText: required && textValue.length <= 0
                  ? 'Field is required'
                  : null,
              hintText: value),
          style: TextStyle(
            fontSize: fontSize.toDouble(),
          ),
        ),
        RaisedButton(
          onPressed: () {
            previewBloc.widgetRemoveSink.add(key.toString());
            exportBloc.codeRemoveSink.add(key.toString());
          },
          child: Text('Remove'),
        ),
      ],
    );
  }

  getCode() {
    return """

    //TextField
    TextField(
      onChanged: (newValue) {
        //textValue=newValue;
        //$textValue
        setState(() {

        });
      },
      decoration: InputDecoration(
        errorText: $required && ${textValue.length <= 0} ? 'Field is required':null,
        hintText: '$value'
      ),
      style: TextStyle(
        fontSize: $fontSize,
      ),
    ),
    """;
  }
}
