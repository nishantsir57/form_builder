import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class CheckboxBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.check_box);
  String name = 'Checkbox';
  Map<String, bool> itemsList = {};
  Map<String, String> itemsMap = {};
  String? dropdownValue;
  String ddValue = '';
  int length = 1;
  double h = 80;
  int fontSize = 18;

  bool showErrorText = false;

  buildDialog(context) {
    itemsMap = {};
    final key = GlobalKey();
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ct, setState) => AlertDialog(
                title: Text(
                  'Add Checkbox Item',
                  style: TextStyle(color: Colors.black),
                ),
                content: AnimatedContainer(
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOutBack,
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
                                  showErrorText = v.length>0?false:true;
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
                        showErrorText = false;
                        length > 1 ? length-- : null;
                        h = h - 50 > 80 && length > 1 ? h - 50 : 80;
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
                      for (int i = 0; i < itemsMap.values.length; i++)
                        itemsList[itemsMap.values.elementAt(i)] = false;
                      itemsMap.values.length > 0
                          ? previewBloc.widgetListUpdateSink.add({key.toString(): _CheckboxBuilderWidget(itemsList, fontSize, key)}) : null;
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
    buildDialog(context);
    return Container();
  }
}

class _CheckboxBuilderWidget extends StatefulWidget {
  Map<String, bool> itemsList;
  int fontSize;
  var key;
  _CheckboxBuilderWidget(this.itemsList, this.fontSize, this.key);
  _CheckboxBuilderState createState() =>
      _CheckboxBuilderState(itemsList, fontSize, key);
}

class _CheckboxBuilderState extends State<_CheckboxBuilderWidget> {
  Map<String, bool> items;
  int fontSize;
  var key;

  _CheckboxBuilderState(this.items, this.fontSize, this.key);

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    String listExportString='{';
    for(int i=0;i<items.keys.length;i++)
      {
        listExportString+="'${items.keys.elementAt(i)}' : ${items.values.elementAt(i)},";
      }
    listExportString+="}";
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    exportBloc.variableUpdateSink.add({key.toString(): ['var checkboxItems = $listExportString;', 'var checkboxFontSize=$fontSize;']});

    return ListTile(
      title: Row(
        children: [
          for (int i = 1; i <= items.length; i++)
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeOutSine,
              padding: EdgeInsets.all(2),
              width:
                  (items.keys.elementAt(i - 1).length + 1) * 8 + fontSize * 5,
              height: 50,
              child: CheckboxListTile(
                title: Text(
                  items.keys.elementAt(i - 1),
                  style: TextStyle(fontSize: fontSize.toDouble()),
                ),
                value: items.values.elementAt(i - 1),
                onChanged: (newValue) {
                  items[items.keys.elementAt(i - 1)] = newValue!;
                  setState(() {});
                },
              ),
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
    String s = '';
      s += """
        getCheckbox()
        {
        return Row(
        children: [
          for (int i = 1; i <= checkboxItems.length; i++)
            AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeOutSine,
              padding: EdgeInsets.all(2),
              width:
                 (checkboxItems.keys.elementAt(i - 1).length + 1) * 8 + checkboxFontSize * 5,
              height: 50,
              child: CheckboxListTile(
                title: Text(
                  checkboxItems.keys.elementAt(i - 1),
                  style: TextStyle(fontSize: checkboxFontSize.toDouble()),
                ),
                value: checkboxItems.values.elementAt(i - 1),
                onChanged: (newValue) {
                  checkboxItems[checkboxItems.keys.elementAt(i - 1)] = newValue!;
                  setState(() {});
                },
              ),
            ),
        ],
      );
        }
      """;
    return s;
  }
  getFunction()
  {
    return "getCheckbox(),\n";
  }
}
