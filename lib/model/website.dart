import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/view/home.dart';

class WebsiteBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.web_asset);
  String name='Website';
  String value='';
  int fontSize=18;
  bool required=false;
  Map<String, bool> checkValues={
    '.com' : false,
    '.edu' : false,
    '.in' : false,
    '.org' : false
  };
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
        title: Text('Create Website Widget', style: TextStyle(color: Colors.black),),
        content: Container(
            height: 120,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white, spreadRadius: 20, blurStyle: BlurStyle.solid)]
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Hint Text',
                        ),
                        onChanged: (v) => value=v,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
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
              previewBloc.widgetListUpdateSink.add(WebsiteBuilderWidget(value, fontSize, required));
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
    
    //Website
    Container(
      child: TextField(
        onChanged: (value){
          newText=value;
          setState(() {
          });
        },
        decoration: InputDecoration(
            errorText: required && newText.length <= 0?'Field is required': null,
          hintText: value,
          prefixText: 'https://www.',
          suffix: DropdownButton(
            value: suffixValue,
            items: ['.com', '.org', '.in', '.edu'].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
            onChanged: (String? value) {
              suffixValue=value!;
              setState(() {
              });
            },

          )
        ),
        style: TextStyle(
          fontSize: fontSize.toDouble(),
        ),
        keyboardType: TextInputType.url,
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
class WebsiteBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;
  bool required;
  WebsiteBuilderWidget(this.value, this.fontSize, this.required);
  WebsiteBuilderState createState() => WebsiteBuilderState(value, fontSize, required);
}
class WebsiteBuilderState extends State<WebsiteBuilderWidget>
{
  String? value;
  String suffixValue='.com';
  int fontSize;
  bool required;
  String newText='h';
  WebsiteBuilderState(this.value, this.fontSize, this.required);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (value){
          newText=value;
          setState(() {

          });
        },
        decoration: InputDecoration(
            errorText: required && newText.length <= 0?'Field is required': null,
          hintText: value,
          prefixText: 'https://www.',
          suffix: DropdownButton(
            value: suffixValue,
            items: ['.com', '.org', '.in', '.edu'].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
            onChanged: (String? value) {
              suffixValue=value!;
              setState(() {
              });
            },

          )
        ),
        style: TextStyle(
          fontSize: fontSize.toDouble(),
        ),
        keyboardType: TextInputType.url,
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    );
  }
}