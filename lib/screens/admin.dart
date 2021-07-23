import 'package:cht/services/ReportService.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:cht/services/DatabaseService.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String rollNo = "";
  @override
  Widget build(BuildContext context) {
    Future<dynamic> raw = ReportService().getRawDatabase(rollNo);
    Future<dynamic> local = _loadallData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
        backgroundColor: Color(0xff273C5C),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: 1200,
          decoration: BoxDecoration(
            color: Color(0xff273C5C),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              //main progress bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        rollNo = value;
                      },
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          raw = ReportService().getRawDatabase(rollNo);
                        });
                      },
                      child: Text("load"))
                ],
              ),
              FutureBuilder(
                future: raw,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null)
                      return Center(
                        child: Container(
                          width: screenWidth,
                          height: screenHeight - 200,
                          child: dataTableFromData(snapshot.data),
                        ),
                      );
                    else
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FutureBuilder(
                            future: local,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return dataTableFromData(snapshot.data);
                              } else {
                                return Text(
                                  "NO DATA",
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                            }),
                      );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<List<Map<String, Object>>> _loadallData() async {
    return (await DatabaseService.db.getallData(DateTime.now()));
  }
}
