import 'package:flutter/material.dart';
import 'history/custom.dart';
import 'welcomescreen/background_welcome.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/signinscr';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool hide = true;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Map<String, String> users = {
    "admin": 'admin',
    "0000": '0000',
    "1": "1",
    "uvs2021": "uvs2021",
  };

  void signIn() {
    if (_formKey.currentState.validate()) {
      var checkpassword = users.keys.firstWhere(
          (k) => users[k] == emailController.text,
          orElse: () => null);
      if (checkpassword == passwordController.text) {
        Navigator.of(context).pushReplacementNamed(CustomDatabase.routeName);
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An Error Occured'),
                  content: Text(
                    'Invalid email or password',
                    style: TextStyle(
                        color: Colors.redAccent[700],
                        decoration: TextDecoration.underline),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Okay',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    )
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          height: size.height,
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
                  Padding(padding: EdgeInsets.all(5)),
                  Container(
                    padding: EdgeInsets.only(top: (size.height * 0.07) + 10),
                    child: Text(
                      'SMART HELMET',
                      style: TextStyle(
                          fontFamily: 'Signatra',
                          fontSize: 50,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                  ),
                  new Image.asset(
                    'assets/images/001.png',
                    height: 200,
                    width: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Stack(children: [
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock_open,
                          color: Theme.of(context).primaryColor,
                        ),
                        hintText: 'Enter your password',
                      ),
                      obscureText: hide,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Positioned(
                      right: 0,
                      child: FlatButton(
                        hoverColor: Colors.white,
                        child: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                      ),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: signIn,
                    child: Text(
                      'sign in',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  )
                ]),
              )),
        ),
      ),
    );
  }
}
