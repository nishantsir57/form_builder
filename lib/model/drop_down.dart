import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class DropdownBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.arrow_drop_down_circle_outlined);
  String name = 'Dropdown';
  Map<String, String> itemsMap = {};
  List<String> list = [];
  String? dropdownValue;
  String ddValue = '';
  int length = 1;
  double h = 80;
  int fontSize = 18;

  var showErrorText = false;

  buildDialog(context) {
    itemsMap = {};
    final key = GlobalKey();
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ct, setState) => AlertDialog(
                title: Text(
                  'Create Dropdown Widget',
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
                                onChanged: (v){
                                  showErrorText = v.length>0?false:true;
                                  v.length > 0
                                      ? itemsMap['$i'] = v
                                      : itemsMap.remove('$i');
                                  setState(() {

                                  });
                                }
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
                        list.add(itemsMap.values.elementAt(i));
                      itemsMap.values.length > 0
                          ? previewBloc.widgetListUpdateSink.add({
                              key.toString(): _DropdownBuilderWidget(
                                  list, ddValue, fontSize, key)
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
                    },
                  ),
                  TextButton(
                    child: Text('cancel'),
                    onPressed: () => Navigator.of(context).pop(),
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

class _DropdownBuilderWidget extends StatefulWidget {
  List<String> itemsList;
  String ddValue;
  int fontSize;
  var key;

  _DropdownBuilderWidget(this.itemsList, this.ddValue, this.fontSize, this.key);

  _DropdownBuilderState createState() =>
      _DropdownBuilderState(itemsList, ddValue, fontSize, key);
}

class _DropdownBuilderState extends State<_DropdownBuilderWidget> {
  List<String> itemsList;
  String dropdownValue;
  int fontSize;
  var key;

  _DropdownBuilderState(
      this.itemsList, this.dropdownValue, this.fontSize, this.key);

  @override
  Widget build(BuildContext context) {
    dropdownValue = itemsList.elementAt(0);
    print(itemsList);
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
    exportBloc.functionUpdateSink.add({key.toString() : getFunction()});
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            iconSize: 30,
            value: dropdownValue,
            items: itemsList
                .map((e) => DropdownMenuItem<String>(
                      child: Text(
                        e,
                        style: TextStyle(fontSize: fontSize.toDouble()),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              dropdownValue = value!;
              setState(() {
              });
            },
          ),
        ),
        Positioned(
          right: 30,
          child: RaisedButton(
            onPressed: () {
              previewBloc.widgetRemoveSink.add(key.toString());
              exportBloc.codeRemoveSink.add(key.toString());
              exportBloc.functionRemoveSink.add(key.toString());
            },
            child: Text('remove'),
          ),
        )
      ],
    );
  }

  getCode() {
    String s = '';
    return """
    //Dropdown
      getDropdown(itemsList, dropdownValue, fontSize)
      {
        return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            iconSize: 20,
            value: dropdownValue,
            items: itemsList
                .map((e) => DropdownMenuItem<String>(
                      child: Text(
                        e,
                        style: TextStyle(fontSize: fontSize.toDouble()),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
          ),
        ),
        Positioned(
          right: 30,
          child: RaisedButton(
            onPressed: () {
              previewBloc.widgetRemoveSink.add(key.toString());
              exportBloc.codeRemoveSink.add(key.toString());
            },
            child: Text('remove'),
          ),
        )
      ],
    );
      }
    """;
  }
  getFunction(){
    return """
      getDropdown($itemsList, '$dropdownValue', $fontSize),
    """;
  }
}
