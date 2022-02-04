import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class DropdownBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.arrow_drop_down_circle_outlined);
  String name='Dropdown';
  List<String> itemsList=[];
  String? dropdownValue;
  String ddValue='';
  int length=1;
  double h=80;
  int fontSize=18;
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (ct, setState) =>AlertDialog(
        title: Text('Create Dropdown Widget', style: TextStyle(color: Colors.black),),
        content: Container(
          height: h,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white, spreadRadius: 20, blurStyle: BlurStyle.solid)]
          ),
          child: Container(
            height: 200,
            child: ListView(
              children: [
                for(int i=1;i<=length;i++)
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter item $i',
                      ),
                      onChanged: (v) => ddValue=v,
                    ),
                  ),
              ],
            ),
          )),
        actions: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              setState(() {
                h=h<270?h+50:270;
                itemsList.add(ddValue);
                length++;
              });
            },
          ),
          TextButton(
            child: Text('Save'),
            onPressed: (){
              itemsList.add(ddValue);
              previewBloc.widgetListUpdateSink.add(DropdownBuilderWidget(itemsList, ddValue, fontSize));
              exportBloc.codeUpdateSink.add(getCode());
              Navigator.of(context).pop();
            },
          )
        ],
      ), )
    );
  }
  getCode()
  {
    return """
    
    //Dropdown
    Container(
      padding: EdgeInsets.all(10),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        iconSize: 20,
        value: dropdownValue,
        items: itemsList.map((e) => DropdownMenuItem<String>(child: Text(e, style: TextStyle(fontSize: fontSize.toDouble()),), value: e,)).toList(),
        onChanged: (value) {
          setState(() {
            dropdownValue=value!;
          });
        },
      ),
    ),
    """;
  }
  @override
  Widget build(BuildContext context) {
    buildDialog(context);
    return Container();
  }

}

class DropdownBuilderWidget extends StatefulWidget
{
  List<String> itemsList;
  String ddValue;
  int fontSize;
  DropdownBuilderWidget(this.itemsList, this.ddValue, this.fontSize);
  DropdownBuilderState createState() => DropdownBuilderState(itemsList, ddValue, fontSize);
}
class DropdownBuilderState extends State<DropdownBuilderWidget>
{
  List<String> itemsList;
  String dropdownValue;
  int fontSize;
  DropdownBuilderState(this.itemsList, this.dropdownValue, this.fontSize);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        iconSize: 20,
        value: dropdownValue,
        items: itemsList.map((e) => DropdownMenuItem<String>(child: Text(e, style: TextStyle(fontSize: fontSize.toDouble()),), value: e,)).toList(),
        onChanged: (value) {
          setState(() {
            dropdownValue=value!;
          });
        },
      ),
    );
  }

}