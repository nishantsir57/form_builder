import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class ParagraphBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.text_snippet);
  String name = 'Paragraph';
  String value = '';
  int fontSize = 18;
  BuildContext? ctx;
  bool required = false;
  double h = 100;

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
                  height: h,
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
                  child: ListView(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          maxLines: 100,
                          decoration: InputDecoration(
                            errorText:
                                showErrorText ? 'This field is required' : null,
                            hintText: 'Enter Paragraph value(required)',
                          ),
                          onChanged: (v) => setState(() {
                            showErrorText = v.length > 0 ? false : true;
                            value = v;
                          }),
                        ),
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
                              key.toString(): _ParagraphBuilderWidget(
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
    this.ctx = context;
    return Container();
  }
}

class _ParagraphBuilderWidget extends StatefulWidget {
  String? value;
  int fontSize;
  bool required;
  var key;

  _ParagraphBuilderWidget(this.value, this.fontSize, this.required, this.key);

  _ParagraphBuilderState createState() =>
      _ParagraphBuilderState(value, fontSize, required, key);
}

class _ParagraphBuilderState extends State<_ParagraphBuilderWidget> {
  String? value;
  int fontSize;
  bool required;
  var key;

  _ParagraphBuilderState(this.value, this.fontSize, this.required, this.key);

  @override
  Widget build(BuildContext context) {
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    exportBloc.variableUpdateSink.add({key.toString(): ['var paragraphValue = "$value";', 'var paragraphFontSize=$fontSize;']});
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
          exportBloc.variableRemoveSink.add(key.toString());
        },
        child: Text('Remove'),
      ),
    );
  }

  getCode() {
    return """
    //Paragraph
    getParagraph(){
      return ListTile(
      title: Text(
        paragraphValue!,
        style: TextStyle(
          fontSize: paragraphFontSize.toDouble(),
        ),
      ),
    );
    }
    """;
  }
  getFunction()
  {
    return "getParagraph(),\n";
  }
}
