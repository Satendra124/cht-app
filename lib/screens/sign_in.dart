import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

import '../services/AuthService.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/appLogo.png"),
            SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth - 70,
              child: ElevatedButton(
                  onPressed: () {
                    // AuthService().signInWithGoogle();
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        child: Image.asset("assets/google_logo.png"),
                      ),
                      Text("Sign in with Google")
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
