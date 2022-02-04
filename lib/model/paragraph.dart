import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class ParagraphBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.text_snippet);
  String name='Paragraph';
  String value='';
  int fontSize=18;
  BuildContext? ctx;
  bool required=false;
  double h=100;
  buildDialog(context)
  {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (_, setState) => AlertDialog(
        title: Text('Create Text Widget', style: TextStyle(color: Colors.black),),
        content: Container(
          height: h,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [BoxShadow(blurRadius: 20, color: Colors.white, spreadRadius: 20, blurStyle: BlurStyle.solid)]
          ),
          child: ListView(
            children: [
              Container(
                height: 60,
                child: TextField(
                  maxLines: 100,
                  decoration: InputDecoration(
                    hintText: 'Enter Paragraph value',
                  ),
                  onChanged: (v) => value=v,
                ),
              ),
            ],
          ),),
        actions: [
          RaisedButton(
            child: Text('Save'),
            onPressed: (){
              previewBloc.widgetListUpdateSink.add(ParagraphBuilderWidget(value, fontSize, required));
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
    
    //Paragraph
    Text(
      value!,
      maxLines: 100,
      style: TextStyle(
        fontSize: fontSize,
      ),
    ),
    """;
  }
  @override
  Widget build(BuildContext context) {
    this.ctx=context;
    return Container();
  }

}
class ParagraphBuilderWidget extends StatefulWidget
{
  String? value;
  int fontSize;
  bool required;
  ParagraphBuilderWidget(this.value, this.fontSize, this.required);
  ParagraphBuilderState createState() => ParagraphBuilderState(value, fontSize, required);
}
class ParagraphBuilderState extends State<ParagraphBuilderWidget>
{
  String? value;
  int fontSize;
  bool required;
  ParagraphBuilderState(this.value, this.fontSize, this.required);
  @override
  Widget build(BuildContext context) {
    return Text(
      value!,
      maxLines: 100,
      style: TextStyle(
        fontSize: fontSize.toDouble(),
      ),
    );
  }

}