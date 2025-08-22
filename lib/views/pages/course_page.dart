import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/classes/activity_class.dart';
import 'package:http/http.dart' as http;


Future<Activity> fetchActivity() async {
  final response =
      await http.get(Uri.parse('https://bored-api.appbrewery.com/random'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return Activity.fromJson(jsonData);
  } else {
    throw Exception('Failed to load activity');
  }
}

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late Future<Activity> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchActivity();
  }

  void _reloadActivity() {
    setState(() {
      futureActivity = fetchActivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bored API Activity'),
      ),
      body: Center(
        child: FutureBuilder<Activity>(
          future: futureActivity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final activity = snapshot.data!;
              return Card(
                margin: const EdgeInsets.all(16),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        activity.activity,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text("Type: ${activity.type}"),
                      Text("Participants: ${activity.participants}"),
                      Text("Kid Friendly: ${activity.kidFriendly ? "Yes" : "No"}"),
                      Text("Duration: ${activity.duration}"),
                      if (activity.link.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            "More info: ${activity.link}",
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _reloadActivity,
                        child: const Text("Get Another Activity"),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('No activity found.');
            }
          },
        ),
      ),
    );
  }
}
