import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TextBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.text_format);
  String name = 'Text';
  String value = '';
  int fontSize = 18;
  bool isBold = false;
  BuildContext? ctx;
  bool showErrorText = false;

  buildDialog(context) {
    final key = GlobalKey();
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
                              showErrorText ? 'this field is required' : null,
                          hintText: 'Enter Text value(required)',
                        ),
                        onChanged: (v) => setState(() {
                          showErrorText = v.length > 0 ? false : true;
                          value = v;
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
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      value.length > 0
                          ? previewBloc.widgetListUpdateSink.add({
                              key.toString():
                                  _TextBuilderWidget(value, fontSize, key)
                            })
                          : null;
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
                  ),
                  RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
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

class _TextBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  var key;

  _TextBuilderWidget(this.value, this.fontSize, this.key);

  _TextBuilderState createState() => _TextBuilderState(value, fontSize, key);
}

class _TextBuilderState extends State<_TextBuilderWidget> {
  String? value;
  int fontSize;
  var key;

  _TextBuilderState(this.value, this.fontSize, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    print(key.toString());
    return ListTile(
      title: Text(
        value!,
        style: TextStyle(
          fontSize: fontSize.toDouble(),
        ),
      ),
      trailing: RaisedButton(
        onPressed: () {
          previewBloc.widgetRemoveSink.add(key.toString());
          exportBloc.codeRemoveSink.add(key.toString());
          exportBloc.functionRemoveSink.add(key.toString());
        },
        child: Text('Remove'),
      ),
    );
  }

  getCode() {
    return """
    //Text
    getText(value, fontSize)
    {
      return Text(
        value,
        style: TextStyle(
          fontSize: fontSize.toDouble(),
        ),
      );
    }
    """;
  }
  getFunction()
  {
    return "getText('$value', $fontSize),\n";
  }
}
