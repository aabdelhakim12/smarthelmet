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
                SizedBox(height: size.height * 0.08),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "welcome to smart helmet app",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Signatra',
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                new Image.asset(
                  'assets/images/004.png',
                  height: size.height * 0.6,
                  width: size.width * 0.85,
                ),
                SizedBox(height: size.height * 0.05),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignInScreen.routeName);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Text('continue',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
