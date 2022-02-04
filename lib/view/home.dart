
import 'package:flutter/material.dart';
import 'package:form_builder/Controller/export_controller.dart';
import 'package:form_builder/Controller/preview_controller.dart';
import 'package:form_builder/Controller/widget_controller.dart';
import 'package:form_builder/model/checkbox.dart';
import 'package:form_builder/model/date.dart';
import 'package:form_builder/model/drop_down.dart';
import 'package:form_builder/model/email.dart';
import 'package:form_builder/model/number.dart';
import 'package:form_builder/model/paragraph.dart';
import 'package:form_builder/model/radio_button.dart';
import 'package:form_builder/model/text.dart';
import 'package:form_builder/model/time.dart';
import 'package:form_builder/model/website.dart';

final widgetBloc=WidgetBloc();
final previewBloc=PreviewBloc();
final exportBloc=ExportBloc();

class Home extends StatefulWidget
{
  HomeState createState()=> HomeState();
}
class HomeState extends State<Home>
{
  final formKey=GlobalKey();
  String fieldName='';
  String hintText='';
  String code='';

  @override
  void dispose(){
    super.dispose();
    widgetBloc.dispose();
    previewBloc.dispose();
    exportBloc.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
  buildBody()
  {
    var w=MediaQuery.of(context).size.width;
    var h=MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
        child: ListView(
      children: [
        Row(
          children: [
            //Creating Pallets
            Container(width: 270, height: h-150, color: Color(0xffffbdfd), child: buildPallets(),),

            //Creating Preview
            Container(width:w-270,height:h-150,color: Colors.white, child: createPreviewPage(),)
          ],
        ),

        StreamBuilder(
            stream: exportBloc.codeStream,
            builder: (BuildContext ctx, AsyncSnapshot<String> snapshot){
              return Container(width: w, height: h/2, color: Colors.white60,child: ListView(
                children: [
                  Text(snapshot.data==null?'':snapshot.data!,),
                ],
              ));
            }
        ),
      ],
    ));
  }
  buildPallets()
  {
    return ListView(
        children: [
          Row(
            children: [
              createIconButton(TextBuilder()),
              createIconButton(ParagraphBuilder()),
            ],
          ),
          Row(
            children: [
              createIconButton(DropdownBuilder()),
              createIconButton(RadioBuilder()),
            ],
          ),
          Row(
            children: [
              createIconButton(CheckboxBuilder()),
              createIconButton(DateBuilder()),
            ],
          ),
          Row(
            children: [
              createIconButton(TimeBuilder()),
              createIconButton(NumberBuilder()),
            ],
          ),
          Row(
            children: [
              createIconButton(WebsiteBuilder()),
              createIconButton(EmailBuilder()),
            ],
          )
        ],
    );

  }
  createPreviewPage()
  {
    return StreamBuilder(
      stream: previewBloc.widgetListStream,
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        return ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data![index];
              });
        }
    );
  }
  createIconButton(wb)
  {
    var icon=wb.icon;
    var name=wb.name;

    return Draggable(
        feedback: Material(child: onDraging(icon)),
        child: staticDragButton(icon, name),
      childWhenDragging: staticDragButton(icon, name),
      onDragEnd: (details) {
          return wb.buildDialog(context);
            // widgetBloc.widgetBuilderListUpdateSink.add(wb);
      },
    );
  }
  onDraging(icon)
  {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
        curve: Curves.easeIn,
        padding: EdgeInsets.all(6),
        child:Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black)
          ),
          child: IconButton(
            visualDensity: VisualDensity.comfortable,
            onPressed: null,
            icon: icon,
            alignment: Alignment.center,
            constraints: BoxConstraints(
                maxHeight: 70,
                maxWidth: 70,
                minHeight: 60,
                minWidth: 60
            ),
            iconSize: 50,
            hoverColor: Colors.green,
          ),
        ));
  }
  staticDragButton(icon, name)
  {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.bounceInOut,
      padding: EdgeInsets.all(5),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black),
          color: Colors.white
        ),
        child: ListTile(
          title: IconButton(
            onPressed: onPressed,
            icon: icon,
            alignment: Alignment.centerLeft,
            iconSize: 45,
            hoverColor: Colors.green,
          ),
          subtitle: Text('$name', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ),
      ),
      );
  }
  createForm()
  {
    return StreamBuilder(
      stream: widgetBloc.widgetBuilderListStream,
      builder: (BuildContext ctx, AsyncSnapshot<List<Widget>> snapshot){
        return ListView.builder(
            itemCount: snapshot.data == null ?0:snapshot.data!.length,
            itemBuilder: (_, index)=> snapshot.data![index]);
    });
  }
  onPressed()
  {

  }

  displayCode()
  {
    return Container(
      child: Text(code),
    );
  }
}