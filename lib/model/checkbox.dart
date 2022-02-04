import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';
import 'dart:html';
class CheckboxBuilder extends StatelessWidget {
  Icon icon = Icon(Icons.check_box);
  String name = 'Checkbox';
  Map<String, bool> itemsList = {};
  String? dropdownValue;
  String ddValue = '';
  int length = 1;
  double h = 80;
  int fontSize = 18;

  buildDialog(context) {
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
                                ),
                                onChanged: (v) => ddValue = v,
                              ),
                            ),
                        ],
                      ),
                    )),
                actions: [
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        h = h < 270 ? h + 50 : 270;
                        itemsList[ddValue] = false;
                        length++;
                      });
                    },
                  ),
                  TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      itemsList[ddValue] = false;
                      previewBloc.widgetListUpdateSink.add(CheckboxBuilderWidget(itemsList, fontSize));
                      exportBloc.codeUpdateSink.add(getCode());
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ));
  }

  getCode() {
    return """
    
    //CheckBox
    Row(
      children: [
        for (int i = 1; i <= 'length of items'; i++)
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutSine,
            padding: EdgeInsets.all(2),
            width: width of container,
            height: 50,
            child:CheckboxListTile(
              title: Text(item value,
                style: TextStyle(fontSize: fontSize,
              ),
              value: //(true or false),
              onChanged: (newValue) {
                //update value here
                setState(() {
                });
              },
            ),
          )

      ],
    )
     """;
  }
  @override
  Widget build(BuildContext context) {
    buildDialog(context);
    return Container();
  }
}

class CheckboxBuilderWidget extends StatefulWidget {
  Map<String, bool> itemsList;
  int fontSize;

  CheckboxBuilderWidget(this.itemsList, this.fontSize);

  CheckboxBuilderState createState() =>
      CheckboxBuilderState(itemsList, fontSize);
}

class CheckboxBuilderState extends State<CheckboxBuilderWidget> {
  Map<String, bool> items;
  int fontSize;

  CheckboxBuilderState(this.items, this.fontSize);

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    print(items.keys.elementAt(0));
    return Row(
      children: [
        for (int i = 1; i <= items.length; i++)
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutSine,
            padding: EdgeInsets.all(2),
            width: (items.keys.elementAt(i-1).length+1)*8+fontSize*5,
            height: 50,
            child:CheckboxListTile(
              title: Text(items.keys.elementAt(i - 1),
                style: TextStyle(fontSize: fontSize.toDouble()),
              ),
              value: items.values.elementAt(i - 1),
              onChanged: (newValue) {
                items[items.keys.elementAt(i - 1)] = newValue!;
                setState(() {
                });
              },
            ),
          )

      ],
    );
  }


}
