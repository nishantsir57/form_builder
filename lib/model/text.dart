import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TextBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.text_format);
  String name='Text';
  String value='';
  int fontSize=18;
  BuildContext? ctx;
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (_, setState)=>AlertDialog(
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
                  hintText: 'Enter Text value',
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
          RaisedButton(
            child: Text('Save'),
            onPressed: (){
              exportBloc.codeUpdateSink.add(getCode());
              previewBloc.widgetListUpdateSink.add(TextBuilderWidget(value, fontSize));
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
    
    //Text
    Text(
      value!,
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
class TextBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;

  TextBuilderWidget(this.value, this.fontSize);
  TextBuilderState createState() => TextBuilderState(value, fontSize);
}
class TextBuilderState extends State<TextBuilderWidget>
{
  String? value;
  int fontSize;
  TextBuilderState(this.value, this.fontSize);
  @override
  Widget build(BuildContext context) {

    return Text(
      value!,
      style: TextStyle(
        fontSize: fontSize.toDouble(),
      ),
    );
  }

}