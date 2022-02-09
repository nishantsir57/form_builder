import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:form_builder/Controller/export_controller.dart';
import 'package:form_builder/Controller/preview_controller.dart';
import 'package:form_builder/Controller/widget_controller.dart';
import 'package:form_builder/model/button.dart';
import 'package:form_builder/model/checkbox.dart';
import 'package:form_builder/model/date.dart';
import 'package:form_builder/model/drop_down.dart';
import 'package:form_builder/model/email.dart';
import 'package:form_builder/model/number.dart';
import 'package:form_builder/model/paragraph.dart';
import 'package:form_builder/model/password.dart';
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
      body: _buildBody(),
    );
  }

  _buildBody() {
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
                height: h + h / 2,
                child: Row(
                  children: [
                    Text(
                      'Business card request form',
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
                color: Colors.grey[400],
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
              top: 130,
              left: 40,
              child: Text(
                'Drag elements to the right',
                style: TextStyle(fontSize: 12),
              )),
          Positioned(
              top: 154,
              child: Container(
                height: 1,
                width: 280,
                color: Colors.grey[400],
              )),
          Positioned(
              top: 155,
              child: Container(
                child: Container(
                  width: 280,
                  height: h - 155,
                  // color: Colors.white30,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200),
                    ]
                  ),
                  child: _buildPallets(),
                ),
              )),
          Positioned(
              top: 91,
              left: 281,
              child: StreamBuilder(
                stream: previewBloc.widgetListStream,
                builder: (_, snapshot) {
                  hp += 70;
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
                height: 730,
                color: Colors.grey[400],
              )),
          Positioned(
            top: h+10,
            child: StreamBuilder(
                stream: exportBloc.codeStream,
                builder: (BuildContext ctx,
                    AsyncSnapshot<Map<String, String>> snapshot) {

                  return Container(
                      width: w,
                      height: h/2-100 ,
                      color: Colors.white30,
                      padding: EdgeInsets.all(40),
                      child: Markdown(
                        selectable: true,
                        padding: EdgeInsets.all(30),
                        softLineBreak: true,
                        data: exportBloc.generateCode(),
                      ),
                  );
                }),
          ),
        ])
      ],
    );
  }

  _buildPallets() => ListView(
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
              createIconButton(PasswordBuilder()),
              createIconButton(ButtonBuilder()),
            ],
          )
        ],
      );

  createPreviewPage() => StreamBuilder(
      stream: previewBloc.widgetListStream,
      builder: (BuildContext context, AsyncSnapshot<Map<String, Widget>> snapshot) {
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
      feedback: Material(child: _onDraging(icon)),
      child: _staticDragButton(icon, name),
      childWhenDragging: _staticDragButton(icon, name),
      onDragEnd: (details) => wb.buildDialog(context),
    );
  }

  _onDraging(icon) => AnimatedContainer(
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

  _staticDragButton(icon, name) => AnimatedContainer(
        duration: Duration(seconds: 2),
        curve: Curves.bounceInOut,
        padding: EdgeInsets.all(2),
        child: Container(
          alignment: Alignment.center,
          width: 80,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white),
          child: ListTile(
            title: IconButton(
              onPressed: onPressed,
              icon: icon,
              alignment: Alignment.topCenter,
              iconSize: 35,
              hoverColor: Colors.green,
            ),
            subtitle: Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  onPressed() {}
}
