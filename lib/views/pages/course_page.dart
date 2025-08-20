import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/constants.dart';
import 'package:flutter_tutorial/views/widgets/hero_widget.dart';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String data = 'No data to display.';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var url =
      Uri.https('bored-api.appbrewery.com', '/random');

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var activity = jsonResponse['activity'];
      data = activity;
    } else {
      log('Request failed with status: ${response.statusCode}.');
    } 
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeroWidget(title: 'Course',),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data, style: KTextStyle.descriptionText,  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
