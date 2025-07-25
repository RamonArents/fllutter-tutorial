import 'package:flutter/material.dart';
import 'package:flutter_tutorial/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

//statefull can refresh
//stateless can't refresh
//setstate to refresh

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: WidgetTree(),
    );
  }
}
