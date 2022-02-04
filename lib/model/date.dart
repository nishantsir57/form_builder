import 'package:flutter/material.dart';
import 'package:form_builder/view/home.dart';

class DateBuilder extends StatelessWidget{
  Icon icon=Icon(Icons.date_range_outlined);
  String name='Date';

  buildDialog(context)
  {
    previewBloc.widgetListUpdateSink.add(DateBuilderWidget());
    exportBloc.codeUpdateSink.add(getCode());
  }
  getCode()
  {
    return """
    
    //Date Picker
    Container(
      alignment: Alignment.center,
      child: ListTile(
        title: Text('\${date.day}/\${date.month}/\${date.year}'),
        leading: Icon(Icons.date_range_outlined),
        onTap: ()async{
          date=(await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1955),
              lastDate: DateTime(2030)
          ))!;
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
class DateBuilderWidget extends StatefulWidget
{
  DateBuilderState createState() => DateBuilderState();
}
class DateBuilderState extends State<DateBuilderWidget>
{
  DateTime date=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListTile(
        title: Text('${date.day}/${date.month}/${date.year}'),
        leading: Icon(Icons.date_range_outlined),
        onTap: ()async{
          date=(await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1955),
              lastDate: DateTime(2030)
          ))!;
          setState(() {
          });
        },
      ),
    );
  }

}