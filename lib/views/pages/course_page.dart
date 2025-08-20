import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/classes/activity_class.dart';
import 'package:flutter_tutorial/data/constants.dart';
import 'package:flutter_tutorial/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    //Use future with async
    var url = Uri.https('bored-api.appbrewery.com', '/random');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Activity.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        // Use future builde with async
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); //Loading data
          }
          if (snapshot.hasData) {
            Activity activity = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(children: [HeroWidget(title: activity.activity)]),
              ),
            );
          } else {
            return Center(child: Text('Error'),);
          }
        },
      ),
    );
  }
}
