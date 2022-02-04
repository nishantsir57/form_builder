import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/view/home.dart';

class EmailBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.email);
  String name='Email';
  String value='';
  bool required=false;
  int fontSize=18;
  String label='';
  buildDialog(context)
  {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: Text('Create Email Widget', style: TextStyle(color: Colors.black),),
            content: Container(
                height: 200,
                width: 600,
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
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter label Text',
                      ),
                      onChanged: (v) => label=v,
                    ),
                  ],
                ),
            ),
            actions: [
              SwitchListTile(value: required, onChanged: (newValue) {
                required=newValue;
                setState((){});
              },
                title: Text('required :'),
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: (){
                  previewBloc.widgetListUpdateSink.add(EmailBuilderWidget(value, fontSize, required, label));
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
    
    //Email
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
            suffix: DropdownButton(
              value: suffixValue,
              items: ['@gmail.com', '@yahoo.com', '@yahoo.in', '@rediffmail.com'].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
              onChanged: (String? value) {
                suffixValue=value!;
                setState(() {
                });
              },

            )
        ),
        style: TextStyle(
          fontSize: fontSize,
        ),
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
class EmailBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;
  bool required;
  String label;
  EmailBuilderWidget(this.value, this.fontSize, this.required, this.label);
  EmailBuilderState createState() => EmailBuilderState(value, fontSize, required, label);
}
class EmailBuilderState extends State<EmailBuilderWidget>
{
  String? value;
  String suffixValue='@gmail.com';
  int fontSize;
  bool required;
  String newText='h';
  String label;
  EmailBuilderState(this.value, this.fontSize, this.required, this.label);
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
            suffix: DropdownButton(
              value: suffixValue,
              items: ['@gmail.com', '@yahoo.com', '@yahoo.in', '@rediffmail.com'].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
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
      ),
      padding: EdgeInsets.all(10),
      width: 200,
    );
  }


}