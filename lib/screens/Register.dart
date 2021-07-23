import 'package:cht/screens/fetch.dart';
import 'package:cht/services/AuthService.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:cht/models/user.dart';

class Register extends StatelessWidget {
  UserData _user;
  TextEditingController name = TextEditingController();
  TextEditingController roll = TextEditingController();
  TextEditingController branch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _user = new UserData();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: screenHeight / 2,
                  width: screenWidth,
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              // hintText: 'Name',
                              // hintStyle: ,

                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          controller: roll,
                          decoration: InputDecoration(
                              labelText: 'Roll No.',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          controller: branch,
                          decoration: InputDecoration(
                              labelText: 'Branch',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent))),
                        ),
                      ],
                    ),
                  )),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 50.0),
                    Container(
                        height: 40.0,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              //_user.name = name.text;
                              //_user.rollNo = roll.text;
                              //_user.branch = branch.text;

                              //AuthService().register(_user);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FetchPage(),
                                  ));
                            },
                            child: Center(
                              child: Text(
                                'Start',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ]));
  }
}
