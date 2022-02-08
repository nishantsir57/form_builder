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
                              key.toString(): NumberBuilderWidget(
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

class NumberBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  bool required;
  var key;

  NumberBuilderWidget(this.value, this.fontSize, this.required, this.key);

  NumberBuilderState createState() =>
      NumberBuilderState(value, fontSize, required, key);
}

class NumberBuilderState extends State<NumberBuilderWidget> {
  String? value;
  int fontSize;
  bool required;
  String text = '9';
  var key;

  NumberBuilderState(this.value, this.fontSize, this.required, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    return ListTile(
      title: Container(
        child: TextField(
          onChanged: (newValue) {
            text = newValue;
            setState(() {});
          },
          decoration: InputDecoration(
            errorText:
                required && text.length <= 0 ? 'This field is required' : null,
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
        },
        child: Text('remove'),
      ),
    );
  }

  getCode() {
    return """
    //Number
    Container(
      child: TextField(
        onChanged: (newValue) {
          //assign new value i.e. $text
          setState(() {
          });
        },
        decoration: InputDecoration(
          errorText: $required && ${text.length}<=0?'This field is required': null,
          hintText: $value,
        ),
        style: TextStyle(
          fontSize: $fontSize,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    ),
    """;
  }
}
