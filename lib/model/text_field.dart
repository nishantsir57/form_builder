import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TextFieldBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.text_format);
  String name='Text';
  String value='';
  int fontSize=18;
  bool required=false;
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (_, setState) => AlertDialog(
        title: Text('Create Text Widget', style: TextStyle(color: Colors.black),),
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
              previewBloc.widgetListUpdateSink.add(TextFieldBuilderWidget(value, fontSize, required));
              exportBloc.codeUpdateSink.add(getCode());
              Navigator.of(context).pop();
            },
          )
        ],
      ),)
    );
  }
  getCode()
  {
    return """
    
    //TextField
    TextField(
      onChanged: (newValue) {
        textValue=newValue;
        setState(() {

        });
      },
      decoration: InputDecoration(
        errorText: required && textValue.length <= 0 ? 'Field is required':null,
        hintText: value
      ),
      style: TextStyle(
        fontSize: fontSize,
      ),
    ),
    """;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
class TextFieldBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;
  bool required;
  TextFieldBuilderWidget(this.value, this.fontSize, this.required);
  TextFieldBuilderState createState() => TextFieldBuilderState(value, fontSize, required);
}
class TextFieldBuilderState extends State<TextFieldBuilderWidget>
{
  String? value;
  int fontSize;
  String textValue='h';
  bool required;
  TextFieldBuilderState(this.value, this.fontSize, this.required);
  @override
  Widget build(BuildContext context) {

    return TextField(
      onChanged: (newValue) {
        textValue=newValue;
        setState(() {

        });
      },
      decoration: InputDecoration(
        errorText: required && textValue.length <= 0 ? 'Field is required':null,
        hintText: value
      ),
      style: TextStyle(
        fontSize: fontSize.toDouble(),
      ),
    );
  }

}