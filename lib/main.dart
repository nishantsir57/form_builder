import 'package:flutter/material.dart';
import 'package:form_builder/Controller/widget_controller.dart';
import 'package:form_builder/view/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<WidgetBloc>(
        create: (context) => WidgetBloc(),
      ),
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
  }
}

