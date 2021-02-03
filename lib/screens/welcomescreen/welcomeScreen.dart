import 'package:flutter/material.dart';
import '../signin.dart';
import 'background_welcome.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.16),
                Container(
                  child: Text(
                    "welcome to smart helmet app",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Signatra',
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                new Image.asset(
                  'assets/images/004.png',
                  height: (size.height * 0.52) - 3,
                  width: size.width * 0.85,
                ),
                SizedBox(height: size.height * 0.025),
                FlatButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignInScreen.routeName);
                    },
                    child: Text('continue',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
