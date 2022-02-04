import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/view/home.dart';

class NumberBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.dialpad);
  String name='Number';
  String value='';
  int fontSize=18;
  bool required=false;
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder:(_, setState) =>  AlertDialog(
            title: Text('Create Number Widget', style: TextStyle(color: Colors.black),),
            content: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white, spreadRadius: 20, blurStyle: BlurStyle.solid)]
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Hint Text',
                    ),
                    onChanged: (v) => value=v,
                  ),
                ],
              ),),
            actions: [
              DropdownButton(
                  value: fontSize,
                  items: [1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50].
                  map((e) => DropdownMenuItem(child: Text('$e'), value: e,)).toList(),
                  onChanged: (int? value){
                    fontSize=value!;
                    setState((){});
                  }
              ),
              SwitchListTile(value: required, onChanged: (newValue) {
                required=newValue;
                setState((){});
              },
                title: Text('required :'),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: (){
                  previewBloc.widgetListUpdateSink.add(NumberBuilderWidget(value, fontSize, required));
                  exportBloc.codeUpdateSink.add(getCode());
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
      )
    );
  }
  getCode()
  {
    return """
    
    //Number
    Container(
      child: TextField(
        onChanged: (newValue) {
          text=newValue;
          setState(() {

          });
        },
        decoration: InputDecoration(
          errorText: required && text.length<=0?'This field is required': null,
          hintText: value,
        ),
        style: TextStyle(
          fontSize: fontSize,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    ),
    """;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
class NumberBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;
  bool required;
  NumberBuilderWidget(this.value, this.fontSize, this.required);
  NumberBuilderState createState() => NumberBuilderState(value, fontSize, required);
}
class NumberBuilderState extends State<NumberBuilderWidget> {
  String? value;
  int fontSize;
  bool required;
  String text = '9';

  NumberBuilderState(this.value, this.fontSize, this.required);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (newValue) {
          text = newValue;
          setState(() {

          });
        },
        decoration: InputDecoration(
          errorText: required && text.length <= 0
              ? 'This field is required'
              : null,
          hintText: value,
        ),
        style: TextStyle(
          fontSize: fontSize.toDouble(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    );
  }
}