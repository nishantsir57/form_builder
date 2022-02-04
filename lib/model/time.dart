import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class TimeBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.timer);
  String name='Time';

  buildDialog(context)
  {
    previewBloc.widgetListUpdateSink.add(TimeBuilderWidget());
    exportBloc.codeUpdateSink.add(getCode());
  }

  getCode()
  {
    return """
    
    //Time Picker
     Container(
      alignment: Alignment.center,
      child: ListTile(
        title: time.hour<12?Text('\${time.hour}:\${time.minute} \${time.period.name.toUpperCase()}')
            :Text('\${time.hour-12}:\${time.minute} \${time.period.name.toUpperCase()}'),
        leading: Icon(Icons.timer),
        onTap: ()async{
          time=(await showTimePicker(
              context: context,
              initialTime: time))!;
          setState(() {
          });
        },
      ),
    ),
    """;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
class TimeBuilderWidget extends StatefulWidget
{
  TimeBuilderState createState() => TimeBuilderState();
}
class TimeBuilderState extends State<TimeBuilderWidget>
{
  TimeOfDay time=TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListTile(
        title: time.hour<12?Text('${time.hour}:${time.minute} ${time.period.name.toUpperCase()}')
            :Text('${time.hour-12}:${time.minute} ${time.period.name.toUpperCase()}'),
        leading: Icon(Icons.timer),
        onTap: ()async{
          time=(await showTimePicker(
              context: context,
              initialTime: time))!;
          setState(() {
          });
        },
      ),
    );
  }

}