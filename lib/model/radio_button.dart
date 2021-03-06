import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class RadioBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.radio_button_checked);
  String name = 'Radio';
  Map<String, String> itemsMap = {};
  List<String> list = [];
  int fontSize = 18;
  String ddValue = '';
  String dropdownValue = '';
  int length = 1;
  double h = 120;
  bool showErrorText = false;

  buildDialog(context) {
    itemsMap = {};
    final key = GlobalKey();
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ct, setState) => AlertDialog(
                title: Text(
                  'Create Text Widget',
                  style: TextStyle(color: Colors.black),
                ),
                content: AnimatedContainer(
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
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    child: Container(
                      height: 200,
                      child: ListView(
                        children: [
                          for (int i = 1; i <= length; i++)
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter item $i',
                                    errorText: (showErrorText) &&
                                            itemsMap['$i'] == null
                                        ? 'Atleast 1 field is required'
                                        : null),
                                onChanged: (v) => setState(() {
                                  showErrorText = false;
                                  v.length > 0
                                      ? itemsMap['$i'] = v
                                      : itemsMap.remove('$i');
                                }),
                              ),
                            ),
                        ],
                      ),
                    )),
                actions: [
                  FloatingActionButton(
                    mini: true,
                    child: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        setState(() {
                          showErrorText = false;
                          length > 1 ? length-- : null;
                          h = h - 50 > 80 && length > 1 ? h - 50 : 80;
                        });
                      });
                    },
                  ),
                  FloatingActionButton(
                    mini: true,
                    child: Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        h = h < 270 ? h + 50 : 270;
                        length++;
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      for (int i = 0; i < itemsMap.values.length; i++) {
                        list.add(itemsMap.values.elementAt(i));
                      }
                      ;
                      itemsMap.values.length > 0
                          ? previewBloc.widgetListUpdateSink.add({
                              key.toString():
                                  _RadioBuilderWidget(fontSize, list, key)
                            })
                          : null;
                      itemsMap.values.length > 0
                          ? setState(() {
                              h = 80;
                              length = 1;
                              Navigator.of(context).pop();
                            })
                          : setState(() {
                              showErrorText = true;
                            });
                      // setState((){showErrorText=true;});
                    },
                  ),
                  TextButton(
                    child: Text('cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _RadioBuilderWidget extends StatefulWidget {
  int fontSize;
  List<String> itemsList;
  var key;

  _RadioBuilderWidget(this.fontSize, this.itemsList, this.key);

  _RadioBuilderState createState() =>
      _RadioBuilderState(fontSize, itemsList, key);
}

class _RadioBuilderState extends State<_RadioBuilderWidget> {
  int value = 1;
  int fontSize;
  List<String> itemsList;
  var key;

  _RadioBuilderState(this.fontSize, this.itemsList, this.key);

  @override
  Widget build(BuildContext context) {
    String listExportString='[';
    for(int i=0;i<itemsList.length;i++)
    {
      listExportString+="'${itemsList.elementAt(i)}',";
    }
    listExportString+="]";
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    exportBloc.variableUpdateSink.add({key.toString(): ['var radioItemsList = $listExportString;',
      'var radioFontSize=$fontSize;', 'var radioValue=$value;']});

    return ListTile(
      title: Row(
        children: [
          for (int i = 1; i <= itemsList.length; i++)
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeOutSine,
              padding: EdgeInsets.all(2),
              width: (itemsList.elementAt(i - 1).length + 1) * 8 + fontSize * 5,
              height: 50,
              child: RadioListTile(
                  value: i,
                  groupValue: value,
                  title: Text(
                    itemsList.elementAt(i - 1),
                    style: TextStyle(fontSize: fontSize.toDouble()),
                  ),
                  onChanged: (int? newVal) {
                    setState(() {
                      value = newVal!;
                    });
                  }),
            ),
        ],
      ),
      trailing: RaisedButton(
        onPressed: () {
          previewBloc.widgetRemoveSink.add(key.toString());
          exportBloc.codeRemoveSink.add(key.toString());
          exportBloc.functionRemoveSink.add(key.toString());
          exportBloc.variableRemoveSink.add(key.toString());
        },
        child: Text('remove'),
      ),
    );
  }

  getCode() {
    return """
      getRadioButton(){
      return ListTile(
      title: Row(
        children: [
          for (int i = 1; i <= radioItemsList.length; i++)
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeOutSine,
              padding: EdgeInsets.all(2),
              width: (radioItemsList.elementAt(i - 1).length + 1) * 8 + radioFontSize * 5,
              height: 50,
              child: RadioListTile(
                  value: i,
                  groupValue: radioValue,
                  title: Text(
                    radioItemsList.elementAt(i - 1),
                    style: TextStyle(fontSize: radioFontSize.toDouble()),
                  ),
                  onChanged: (int? newVal) {
                    setState(() {
                      radioValue = newVal!;
                    });
                  }),
            ),
        ],
      ),
    );
      }
    """;
  }
  getFunction()
  {
    return "getRadioButton(),\n";
  }
}
