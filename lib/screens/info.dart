import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(child: Text("Project On Development")),
            Spacer()
          ],
        ),
      ),
    );
  }
}
