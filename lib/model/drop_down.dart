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
                              key.toString(): DropdownBuilderWidget(
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

class DropdownBuilderWidget extends StatefulWidget {
  List<String> itemsList;
  String ddValue;
  int fontSize;
  var key;

  DropdownBuilderWidget(this.itemsList, this.ddValue, this.fontSize, this.key);

  DropdownBuilderState createState() =>
      DropdownBuilderState(itemsList, ddValue, fontSize, key);
}

class DropdownBuilderState extends State<DropdownBuilderWidget> {
  List<String> itemsList;
  String dropdownValue;
  int fontSize;
  var key;

  DropdownBuilderState(
      this.itemsList, this.dropdownValue, this.fontSize, this.key);

  @override
  Widget build(BuildContext context) {
    dropdownValue = itemsList.elementAt(0);
    exportBloc.codeUpdateSink.add({key.toString(): getCode()});
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

  getCode() {
    String s = '';

    return """
    //Dropdown
    Container(
          padding: EdgeInsets.all(10),
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(20),
            iconSize: 20,
            value: $dropdownValue,
            items: ${itemsList}.map((e) => DropdownMenuItem<String>(child: Text(e, style: TextStyle(fontSize: fontSize.toDouble()),), value: e,)).toList(),
            onChanged: (value) {
              setState(() {
                '$dropdownValue'
              });
            },
          ),
        ),
    """;
  }
}
