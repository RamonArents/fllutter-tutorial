import 'package:flutter/material.dart';

class ExpanedFlexiblePage extends StatelessWidget {
  const ExpanedFlexiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 20.0,
                  child: Text('Hello'),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.orange,
                  height: 20.0,
                  child: Text('Hello'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.orange,
                  height: 20.0,
                  child: Text('Hello'),
                ),
              ),
              Divider(),
              Expanded(
                child: Container(
                  color: Colors.teal,
                  height: 20.0,
                  child: Text('Hello'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
