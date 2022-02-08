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
                                  TextBuilderWidget(value, fontSize, key)
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

class TextBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  var key;

  TextBuilderWidget(this.value, this.fontSize, this.key);

  TextBuilderState createState() => TextBuilderState(value, fontSize, key);
}

class TextBuilderState extends State<TextBuilderWidget> {
  String? value;
  int fontSize;
  var key;

  TextBuilderState(this.value, this.fontSize, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
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
        },
        child: Text('Remove'),
      ),
    );
  }

  getCode() {
    return """
    //Text
    Text(
        '$value',
        style: TextStyle(
          fontSize: ${fontSize.toDouble()},
        ),
      ),
    """;
  }
}
