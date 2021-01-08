import 'package:flutter/material.dart';
import 'package:flutter_app/src/client.dart';
import './search_screen.dart';
import 'client.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Walid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Takeaway',
        dio: dio,
      ),
    );
  }
}
