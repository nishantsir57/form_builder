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

final widgetBloc = WidgetBloc();
final previewBloc = PreviewBloc();
final exportBloc = ExportBloc();

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final formKey = GlobalKey();
  String fieldName = '';
  String hintText = '';
  String code = '';
  double hp = 100;

  @override
  void dispose() {
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

  buildBody() {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Stack(children: [
          Container(
              padding: EdgeInsets.fromLTRB(40, 20, 10, 20),
              color: Colors.white10,
              child: Container(
                color: Colors.white,
                alignment: Alignment.topLeft,
                height: h + h / 2 - 100,
                child: Row(
                  children: [
                    Text(
                      'Business card rquest form',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Icon(Icons.edit)
                  ],
                ),
              )),
          Positioned(
              top: 90,
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              )),
          Positioned(
              top: 91,
              child: Container(
                padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                height: 100,
                width: 280,
                color: Colors.white,
                child: Text(
                  'Form elements',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )),
          Positioned(
              top: 120,
              left: 40,
              child: Text(
                'Drag elements to the right',
                style: TextStyle(fontSize: 12),
              )),
          Positioned(
              top: 144,
              child: Container(
                height: 1,
                width: 280,
                color: Colors.black,
              )),
          Positioned(
              top: 145,
              child: Container(
                child: Container(
                  width: 280,
                  height: h - 150,
                  color: Colors.red[100],
                  child: buildPallets(),
                ),
              )),
          Positioned(
              top: 91,
              left: 281,
              child: StreamBuilder(
                stream: previewBloc.widgetListStream,
                builder: (_, snapshot) {
                  hp += 50;
                  return Container(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 60),
                    width: w - 270,
                    height: hp <= h - 80 ? hp : h - 80,
                    color: Color(0xffedebe6),
                    child: createPreviewPage(),
                  );
                },
              )),
          Positioned(
              left: 280,
              top: 91,
              child: Container(
                width: 1,
                height: 635,
                color: Colors.black,
              )),
          Positioned(
            top: h,
            child: StreamBuilder(
                stream: exportBloc.codeStream,
                builder: (BuildContext ctx,
                    AsyncSnapshot<Map<String, String>> snapshot) {
                  int size = snapshot.data == null ? 0 : snapshot.data!.length;
                  return Container(
                      width: w,
                      height: h / 2 - 50,
                      color: Colors.white30,
                      child: ListView(
                        children: [
                          for (int i = 0; i < size; i++)
                            Text(snapshot.data!.values.elementAt(i)),
                        ],
                      ));
                }),
          ),
        ])
      ],
    );
  }

  buildPallets() =>ListView(
    children: [
      Row(
        children: [
          createIconButton(TextBuilder()),
          createIconButton(ParagraphBuilder()),
          createIconButton(DropdownBuilder()),
        ],
      ),
      Row(
        children: [
          createIconButton(RadioBuilder()),
          createIconButton(CheckboxBuilder()),
          createIconButton(DateBuilder()),
        ],
      ),
      Row(
        children: [
          createIconButton(TimeBuilder()),
          createIconButton(NumberBuilder()),
          createIconButton(WebsiteBuilder()),
        ],
      ),
      Row(
        children: [
          createIconButton(EmailBuilder()),
        ],
      )
    ],
  );

  createPreviewPage() => StreamBuilder(
      stream: previewBloc.widgetListStream,
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, Widget>> snapshot) {
        return Container(
          height: 50,
          width: 270,
          color: Colors.white,
          child: ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
              itemBuilder: (context, index) {
                return snapshot.data!.values.elementAt(index);
              }),
        );
      });

  createIconButton(wb) {
    var icon = wb.icon;
    var name = wb.name;

    return Draggable(
      feedback: Material(child: onDraging(icon)),
      child: staticDragButton(icon, name),
      childWhenDragging: staticDragButton(icon, name),
      onDragEnd: (details)=>wb.buildDialog(context),
    );
  }

  onDraging(icon) =>AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.easeIn,
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black)),
        child: IconButton(
          visualDensity: VisualDensity.comfortable,
          onPressed: null,
          icon: icon,
          alignment: Alignment.center,
          constraints: BoxConstraints(
              maxHeight: 70, maxWidth: 70, minHeight: 60, minWidth: 60),
          iconSize: 50,
          hoverColor: Colors.green,
        ),
      ));

  staticDragButton(icon, name) => AnimatedContainer(
    duration: Duration(seconds: 2),
    curve: Curves.bounceInOut,
    padding: EdgeInsets.all(5),
    child: Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
          color: Colors.white),
      child: ListTile(
        title: IconButton(
          onPressed: onPressed,
          icon: icon,
          alignment: Alignment.centerLeft,
          iconSize: 25,
          hoverColor: Colors.green,
        ),
        subtitle: Text(
          '$name',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  createForm() => StreamBuilder(
      stream: widgetBloc.widgetBuilderListStream,
      builder: (BuildContext ctx, AsyncSnapshot<List<Widget>> snapshot) {
        return ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
            itemBuilder: (_, index) => snapshot.data![index]);
      });

  onPressed() {}
}
