import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class RadioBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.radio_button_checked);
  String name='Radio';
  List<String> itemsList=[];
  int fontSize=18;
  String ddValue='';
  String dropdownValue='';
  int length=1;
  double h=120;
  buildDialog(context)
  {
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(builder: (ct, setState) =>AlertDialog(
          title: Text('Create Text Widget', style: TextStyle(color: Colors.black),),
          content: AnimatedContainer(
              height: h,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white, spreadRadius: 20, blurStyle: BlurStyle.solid)]
              ),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOut,
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
                previewBloc.widgetListUpdateSink.add(RadioBuilderWidget(fontSize, itemsList));
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
    
    //Radio Button
    Row(
      children: [
        for(int i=1;i<=length;i++)
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutSine,
            padding: EdgeInsets.all(2),
            width: width of container,
            height: 50,
            child:RadioListTile(
                value: i,
                groupValue: value,
                title: Text(//item value,
                 style: TextStyle(fontSize: //fontSize,
                 ),

                onChanged: (int? newVal){
                  setState(() {
                    value=newVal!;
                  });
                }),
          )
      ],
    )
    """;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
class RadioBuilderWidget extends StatefulWidget
{
  int fontSize;
  List<String> itemsList;
  RadioBuilderWidget(this.fontSize, this.itemsList);
  RadioBuilderState createState() => RadioBuilderState(fontSize, itemsList);
}
class RadioBuilderState extends State<RadioBuilderWidget>
{
  int value=1;
  int fontSize;
  List<String> itemsList;
  RadioBuilderState(this.fontSize, this.itemsList);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(int i=1;i<=itemsList.length;i++)
          AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeOutSine,
            padding: EdgeInsets.all(2),
            width: (itemsList.elementAt(i-1).length+1)*8+fontSize*5,
            height: 50,
            child:RadioListTile(
                value: i,
                groupValue: value,
                title: Text(itemsList.elementAt(i-1), style: TextStyle(fontSize: fontSize.toDouble()),),

                onChanged: (int? newVal){
                  setState(() {
                    value=newVal!;
                  });
                }),
          )
      ],
    );
  }

}